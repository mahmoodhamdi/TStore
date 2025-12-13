import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';
import 'package:t_store/features/personalization/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/domain/usecases/get_profile_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/update_profile_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/get_addresses_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/add_address_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/update_address_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/delete_address_usecase.dart';
import 'package:t_store/features/personalization/presentation/cubit/profile_cubit.dart';
import 'package:t_store/features/personalization/presentation/cubit/profile_state.dart';
import 'package:t_store/features/personalization/presentation/cubit/addresses_cubit.dart';
import 'package:t_store/features/personalization/presentation/cubit/addresses_state.dart';

// Mocks
class MockGetProfileUsecase extends Mock implements GetProfileUsecase {}

class MockUpdateProfileUsecase extends Mock implements UpdateProfileUsecase {}

class MockGetAddressesUsecase extends Mock implements GetAddressesUsecase {}

class MockAddAddressUsecase extends Mock implements AddAddressUsecase {}

class MockUpdateAddressUsecase extends Mock implements UpdateAddressUsecase {}

class MockDeleteAddressUsecase extends Mock implements DeleteAddressUsecase {}

// Fakes
class FakeNoParams extends Fake implements NoParams {}

class FakeUpdateProfileParams extends Fake implements UpdateProfileParams {}

class FakeAddAddressParams extends Fake implements AddAddressParams {}

class FakeUpdateAddressParams extends Fake implements UpdateAddressParams {}

void main() {
  // Test data
  const testUser = UserEntity(
    id: 'user-1',
    email: 'test@example.com',
    fullName: 'Test User',
    phone: '+1234567890',
  );

  const updatedUser = UserEntity(
    id: 'user-1',
    email: 'test@example.com',
    fullName: 'Updated User',
    phone: '+0987654321',
  );

  final testAddresses = [
    AddressEntity(
      id: 'address-1',
      userId: 'user-1',
      fullName: 'Test User',
      phone: '+1234567890',
      addressLine1: '123 Main Street',
      addressLine2: 'Apt 4B',
      city: 'New York',
      state: 'NY',
      postalCode: '10001',
      country: 'USA',
      isDefault: true,
      createdAt: DateTime(2024, 1, 15),
    ),
    const AddressEntity(
      id: 'address-2',
      userId: 'user-1',
      fullName: 'Test User',
      phone: '+1234567890',
      addressLine1: '456 Oak Avenue',
      city: 'Los Angeles',
      state: 'CA',
      postalCode: '90001',
      country: 'USA',
      isDefault: false,
    ),
  ];

  final newAddress = AddressEntity(
    id: 'address-3',
    userId: 'user-1',
    fullName: 'Test User',
    phone: '+1234567890',
    addressLine1: '789 Pine Road',
    city: 'Chicago',
    state: 'IL',
    postalCode: '60601',
    country: 'USA',
    isDefault: false,
    createdAt: DateTime.now(),
  );

  setUpAll(() {
    registerFallbackValue(FakeNoParams());
    registerFallbackValue(FakeUpdateProfileParams());
    registerFallbackValue(FakeAddAddressParams());
    registerFallbackValue(FakeUpdateAddressParams());
  });

  group('ProfileCubit', () {
    late ProfileCubit profileCubit;
    late MockGetProfileUsecase mockGetProfileUsecase;
    late MockUpdateProfileUsecase mockUpdateProfileUsecase;

    setUp(() {
      mockGetProfileUsecase = MockGetProfileUsecase();
      mockUpdateProfileUsecase = MockUpdateProfileUsecase();

      profileCubit = ProfileCubit(
        getProfileUsecase: mockGetProfileUsecase,
        updateProfileUsecase: mockUpdateProfileUsecase,
      );
    });

    tearDown(() {
      profileCubit.close();
    });

    test('initial state is ProfileInitial', () {
      expect(profileCubit.state, ProfileInitial());
    });

    group('getProfile', () {
      blocTest<ProfileCubit, ProfileState>(
        'emits [ProfileLoading, ProfileLoaded] when getProfile succeeds',
        build: () {
          when(() => mockGetProfileUsecase(any()))
              .thenAnswer((_) async => const Right(testUser));
          return profileCubit;
        },
        act: (cubit) => cubit.getProfile(),
        expect: () => [
          ProfileLoading(),
          const ProfileLoaded(testUser),
        ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'emits [ProfileLoading, ProfileError] when getProfile fails',
        build: () {
          when(() => mockGetProfileUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to load profile'));
          return profileCubit;
        },
        act: (cubit) => cubit.getProfile(),
        expect: () => [
          ProfileLoading(),
          const ProfileError('Failed to load profile'),
        ],
      );
    });

    group('updateProfile', () {
      blocTest<ProfileCubit, ProfileState>(
        'emits [ProfileUpdating, ProfileUpdated, ProfileLoaded] when updateProfile succeeds',
        build: () {
          when(() => mockUpdateProfileUsecase(any()))
              .thenAnswer((_) async => const Right(updatedUser));
          return profileCubit;
        },
        act: (cubit) => cubit.updateProfile(
          fullName: 'Updated User',
          phone: '+0987654321',
        ),
        expect: () => [
          ProfileUpdating(),
          const ProfileUpdated(updatedUser),
          const ProfileLoaded(updatedUser),
        ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'emits [ProfileUpdating, ProfileError] when updateProfile fails',
        build: () {
          when(() => mockUpdateProfileUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to update profile'));
          return profileCubit;
        },
        act: (cubit) => cubit.updateProfile(fullName: 'Test'),
        expect: () => [
          ProfileUpdating(),
          const ProfileError('Failed to update profile'),
        ],
      );

      blocTest<ProfileCubit, ProfileState>(
        'passes parameters to usecase correctly',
        build: () {
          when(() => mockUpdateProfileUsecase(any()))
              .thenAnswer((_) async => const Right(updatedUser));
          return profileCubit;
        },
        act: (cubit) => cubit.updateProfile(
          fullName: 'New Name',
          phone: '+1111111111',
        ),
        verify: (_) {
          final captured =
              verify(() => mockUpdateProfileUsecase(captureAny())).captured.first
                  as UpdateProfileParams;
          expect(captured.fullName, 'New Name');
          expect(captured.phone, '+1111111111');
        },
      );
    });
  });

  group('AddressesCubit', () {
    late AddressesCubit addressesCubit;
    late MockGetAddressesUsecase mockGetAddressesUsecase;
    late MockAddAddressUsecase mockAddAddressUsecase;
    late MockUpdateAddressUsecase mockUpdateAddressUsecase;
    late MockDeleteAddressUsecase mockDeleteAddressUsecase;

    setUp(() {
      mockGetAddressesUsecase = MockGetAddressesUsecase();
      mockAddAddressUsecase = MockAddAddressUsecase();
      mockUpdateAddressUsecase = MockUpdateAddressUsecase();
      mockDeleteAddressUsecase = MockDeleteAddressUsecase();

      addressesCubit = AddressesCubit(
        getAddressesUsecase: mockGetAddressesUsecase,
        addAddressUsecase: mockAddAddressUsecase,
        updateAddressUsecase: mockUpdateAddressUsecase,
        deleteAddressUsecase: mockDeleteAddressUsecase,
      );
    });

    tearDown(() {
      addressesCubit.close();
    });

    test('initial state is AddressesInitial', () {
      expect(addressesCubit.state, AddressesInitial());
    });

    group('getAddresses', () {
      blocTest<AddressesCubit, AddressesState>(
        'emits [AddressesLoading, AddressesLoaded] when getAddresses succeeds',
        build: () {
          when(() => mockGetAddressesUsecase(any()))
              .thenAnswer((_) async => Right(testAddresses));
          return addressesCubit;
        },
        act: (cubit) => cubit.getAddresses(),
        expect: () => [
          AddressesLoading(),
          AddressesLoaded(testAddresses),
        ],
      );

      blocTest<AddressesCubit, AddressesState>(
        'emits [AddressesLoading, AddressesError] when getAddresses fails',
        build: () {
          when(() => mockGetAddressesUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to load addresses'));
          return addressesCubit;
        },
        act: (cubit) => cubit.getAddresses(),
        expect: () => [
          AddressesLoading(),
          const AddressesError('Failed to load addresses'),
        ],
      );

      blocTest<AddressesCubit, AddressesState>(
        'emits [AddressesLoading, AddressesLoaded] with empty list when no addresses',
        build: () {
          when(() => mockGetAddressesUsecase(any()))
              .thenAnswer((_) async => const Right([]));
          return addressesCubit;
        },
        act: (cubit) => cubit.getAddresses(),
        expect: () => [
          AddressesLoading(),
          const AddressesLoaded([]),
        ],
      );
    });

    group('addAddress', () {
      blocTest<AddressesCubit, AddressesState>(
        'emits [AddressAdding, AddressAdded] then refreshes when addAddress succeeds',
        build: () {
          when(() => mockAddAddressUsecase(any()))
              .thenAnswer((_) async => Right(newAddress));
          when(() => mockGetAddressesUsecase(any()))
              .thenAnswer((_) async => Right([...testAddresses, newAddress]));
          return addressesCubit;
        },
        act: (cubit) => cubit.addAddress(
          fullName: 'Test User',
          phone: '+1234567890',
          addressLine1: '789 Pine Road',
          city: 'Chicago',
          country: 'USA',
        ),
        expect: () => [
          AddressAdding(),
          AddressAdded(newAddress),
          AddressesLoading(),
          AddressesLoaded([...testAddresses, newAddress]),
        ],
      );

      blocTest<AddressesCubit, AddressesState>(
        'emits [AddressAdding, AddressesError] when addAddress fails',
        build: () {
          when(() => mockAddAddressUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to add address'));
          return addressesCubit;
        },
        act: (cubit) => cubit.addAddress(
          fullName: 'Test',
          phone: '+1234567890',
          addressLine1: '123 Test St',
          city: 'Test City',
          country: 'Test Country',
        ),
        expect: () => [
          AddressAdding(),
          const AddressesError('Failed to add address'),
        ],
      );
    });

    group('updateAddress', () {
      blocTest<AddressesCubit, AddressesState>(
        'emits [AddressUpdating, AddressUpdated] then refreshes when updateAddress succeeds',
        build: () {
          final updated = testAddresses.first.copyWith(fullName: 'Updated Name');
          when(() => mockUpdateAddressUsecase(any()))
              .thenAnswer((_) async => Right(updated));
          when(() => mockGetAddressesUsecase(any()))
              .thenAnswer((_) async => Right([updated, testAddresses[1]]));
          return addressesCubit;
        },
        act: (cubit) => cubit.updateAddress(
          id: 'address-1',
          fullName: 'Updated Name',
          phone: '+1234567890',
          addressLine1: '123 Main Street',
          city: 'New York',
          country: 'USA',
        ),
        verify: (_) {
          verify(() => mockUpdateAddressUsecase(any())).called(1);
        },
      );

      blocTest<AddressesCubit, AddressesState>(
        'emits [AddressUpdating, AddressesError] when updateAddress fails',
        build: () {
          when(() => mockUpdateAddressUsecase(any()))
              .thenAnswer((_) async => const Left('Failed to update address'));
          return addressesCubit;
        },
        act: (cubit) => cubit.updateAddress(
          id: 'address-1',
          fullName: 'Test',
          phone: '+1234567890',
          addressLine1: '123 Test St',
          city: 'Test City',
          country: 'Test Country',
        ),
        expect: () => [
          AddressUpdating(),
          const AddressesError('Failed to update address'),
        ],
      );
    });

    group('deleteAddress', () {
      blocTest<AddressesCubit, AddressesState>(
        'emits [AddressDeleted] then refreshes when deleteAddress succeeds',
        build: () {
          when(() => mockDeleteAddressUsecase('address-1'))
              .thenAnswer((_) async => const Right(null));
          when(() => mockGetAddressesUsecase(any()))
              .thenAnswer((_) async => Right([testAddresses[1]]));
          return addressesCubit;
        },
        act: (cubit) => cubit.deleteAddress('address-1'),
        expect: () => [
          const AddressDeleted('address-1'),
          AddressesLoading(),
          AddressesLoaded([testAddresses[1]]),
        ],
      );

      blocTest<AddressesCubit, AddressesState>(
        'emits [AddressesError] when deleteAddress fails',
        build: () {
          when(() => mockDeleteAddressUsecase('address-1'))
              .thenAnswer((_) async => const Left('Failed to delete address'));
          return addressesCubit;
        },
        act: (cubit) => cubit.deleteAddress('address-1'),
        expect: () => [
          const AddressesError('Failed to delete address'),
        ],
      );
    });
  });

  group('AddressEntity', () {
    test('fullAddress formats correctly with all fields', () {
      final address = testAddresses.first;
      expect(address.fullAddress,
          '123 Main Street, Apt 4B, New York, NY, USA, 10001');
    });

    test('fullAddress formats correctly without optional fields', () {
      const address = AddressEntity(
        id: 'address-1',
        userId: 'user-1',
        fullName: 'Test User',
        phone: '+1234567890',
        addressLine1: '123 Main Street',
        city: 'New York',
        country: 'USA',
      );
      expect(address.fullAddress, '123 Main Street, New York, USA');
    });

    test('copyWith creates a new instance with updated values', () {
      final original = testAddresses.first;
      final updated = original.copyWith(
        fullName: 'Updated Name',
        isDefault: false,
      );

      expect(updated.id, original.id);
      expect(updated.userId, original.userId);
      expect(updated.fullName, 'Updated Name');
      expect(updated.isDefault, false);
      expect(updated.addressLine1, original.addressLine1);
    });

    test('equality works correctly', () {
      final address1 = AddressEntity(
        id: 'address-1',
        userId: 'user-1',
        fullName: 'Test User',
        phone: '+1234567890',
        addressLine1: '123 Main Street',
        city: 'New York',
        country: 'USA',
        createdAt: DateTime(2024, 1, 15),
      );

      final address2 = AddressEntity(
        id: 'address-1',
        userId: 'user-1',
        fullName: 'Test User',
        phone: '+1234567890',
        addressLine1: '123 Main Street',
        city: 'New York',
        country: 'USA',
        createdAt: DateTime(2024, 1, 15),
      );

      expect(address1, equals(address2));
    });
  });

  group('AddressesLoaded', () {
    test('defaultAddress returns address with isDefault true', () {
      final state = AddressesLoaded(testAddresses);
      expect(state.defaultAddress, testAddresses.first);
    });

    test('defaultAddress returns null when no default address', () {
      final addresses = [
        const AddressEntity(
          id: 'address-1',
          userId: 'user-1',
          fullName: 'Test User',
          phone: '+1234567890',
          addressLine1: '123 Main Street',
          city: 'New York',
          country: 'USA',
          isDefault: false,
        ),
      ];
      final state = AddressesLoaded(addresses);
      expect(state.defaultAddress, isNull);
    });
  });
}

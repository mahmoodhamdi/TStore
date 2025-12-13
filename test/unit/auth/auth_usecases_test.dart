import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';
import 'package:t_store/features/auth/domain/repositories/auth_repository.dart';
import 'package:t_store/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/get_current_user_usecase.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
  });

  group('SignInUsecase', () {
    late SignInUsecase usecase;

    setUp(() {
      usecase = SignInUsecase(mockRepository);
    });

    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    final testUser = UserEntity(
      id: 'test-id',
      email: testEmail,
      fullName: 'Test User',
    );

    test('should return UserEntity when sign in is successful', () async {
      // Arrange
      when(() => mockRepository.signIn(
            email: testEmail,
            password: testPassword,
          )).thenAnswer((_) async => Right(testUser));

      // Act
      final result = await usecase(SignInParams(
        email: testEmail,
        password: testPassword,
      ));

      // Assert
      expect(result, Right(testUser));
      verify(() => mockRepository.signIn(
            email: testEmail,
            password: testPassword,
          )).called(1);
    });

    test('should return error message when sign in fails', () async {
      // Arrange
      const errorMessage = 'Invalid credentials';
      when(() => mockRepository.signIn(
            email: testEmail,
            password: testPassword,
          )).thenAnswer((_) async => const Left(errorMessage));

      // Act
      final result = await usecase(SignInParams(
        email: testEmail,
        password: testPassword,
      ));

      // Assert
      expect(result, const Left(errorMessage));
    });
  });

  group('SignUpUsecase', () {
    late SignUpUsecase usecase;

    setUp(() {
      usecase = SignUpUsecase(mockRepository);
    });

    const testEmail = 'newuser@example.com';
    const testPassword = 'password123';
    const testFullName = 'New User';
    const testPhone = '+1234567890';
    final testUser = UserEntity(
      id: 'new-id',
      email: testEmail,
      fullName: testFullName,
      phone: testPhone,
    );

    test('should return UserEntity when sign up is successful', () async {
      // Arrange
      when(() => mockRepository.signUp(
            email: testEmail,
            password: testPassword,
            fullName: testFullName,
            phone: testPhone,
          )).thenAnswer((_) async => Right(testUser));

      // Act
      final result = await usecase(SignUpParams(
        email: testEmail,
        password: testPassword,
        fullName: testFullName,
        phone: testPhone,
      ));

      // Assert
      expect(result, Right(testUser));
      verify(() => mockRepository.signUp(
            email: testEmail,
            password: testPassword,
            fullName: testFullName,
            phone: testPhone,
          )).called(1);
    });

    test('should return error when email is already registered', () async {
      // Arrange
      const errorMessage = 'Email already registered';
      when(() => mockRepository.signUp(
            email: testEmail,
            password: testPassword,
            fullName: testFullName,
            phone: testPhone,
          )).thenAnswer((_) async => const Left(errorMessage));

      // Act
      final result = await usecase(SignUpParams(
        email: testEmail,
        password: testPassword,
        fullName: testFullName,
        phone: testPhone,
      ));

      // Assert
      expect(result, const Left(errorMessage));
    });

    test('should work without phone number', () async {
      // Arrange
      final userWithoutPhone = UserEntity(
        id: 'new-id',
        email: testEmail,
        fullName: testFullName,
      );

      when(() => mockRepository.signUp(
            email: testEmail,
            password: testPassword,
            fullName: testFullName,
            phone: null,
          )).thenAnswer((_) async => Right(userWithoutPhone));

      // Act
      final result = await usecase(SignUpParams(
        email: testEmail,
        password: testPassword,
        fullName: testFullName,
      ));

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected Right but got Left'),
        (user) => expect(user.phone, null),
      );
    });
  });

  group('SignOutUsecase', () {
    late SignOutUsecase usecase;

    setUp(() {
      usecase = SignOutUsecase(mockRepository);
    });

    test('should return void when sign out is successful', () async {
      // Arrange
      when(() => mockRepository.signOut())
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(const NoParams());

      // Assert
      expect(result.isRight(), true);
      verify(() => mockRepository.signOut()).called(1);
    });

    test('should return error when sign out fails', () async {
      // Arrange
      const errorMessage = 'Sign out failed';
      when(() => mockRepository.signOut())
          .thenAnswer((_) async => const Left(errorMessage));

      // Act
      final result = await usecase(const NoParams());

      // Assert
      expect(result, const Left(errorMessage));
    });
  });

  group('ResetPasswordUsecase', () {
    late ResetPasswordUsecase usecase;

    setUp(() {
      usecase = ResetPasswordUsecase(mockRepository);
    });

    const testEmail = 'test@example.com';

    test('should return void when reset password is successful', () async {
      // Arrange
      when(() => mockRepository.resetPassword(testEmail))
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(testEmail);

      // Assert
      expect(result.isRight(), true);
      verify(() => mockRepository.resetPassword(testEmail)).called(1);
    });

    test('should return error when email is not found', () async {
      // Arrange
      const errorMessage = 'Email not found';
      when(() => mockRepository.resetPassword(testEmail))
          .thenAnswer((_) async => const Left(errorMessage));

      // Act
      final result = await usecase(testEmail);

      // Assert
      expect(result, const Left(errorMessage));
    });
  });

  group('GetCurrentUserUsecase', () {
    late GetCurrentUserUsecase usecase;

    setUp(() {
      usecase = GetCurrentUserUsecase(mockRepository);
    });

    test('should return UserEntity when user is logged in', () async {
      // Arrange
      final testUser = UserEntity(
        id: 'test-id',
        email: 'test@example.com',
        fullName: 'Test User',
      );
      when(() => mockRepository.getCurrentUser())
          .thenAnswer((_) async => Right(testUser));

      // Act
      final result = await usecase(const NoParams());

      // Assert
      expect(result, Right(testUser));
      verify(() => mockRepository.getCurrentUser()).called(1);
    });

    test('should return null when no user is logged in', () async {
      // Arrange
      when(() => mockRepository.getCurrentUser())
          .thenAnswer((_) async => const Right(null));

      // Act
      final result = await usecase(const NoParams());

      // Assert
      expect(result.isRight(), true);
      result.fold(
        (error) => fail('Expected Right but got Left'),
        (user) => expect(user, null),
      );
    });

    test('should return error when fetching user fails', () async {
      // Arrange
      const errorMessage = 'Failed to get current user';
      when(() => mockRepository.getCurrentUser())
          .thenAnswer((_) async => const Left(errorMessage));

      // Act
      final result = await usecase(const NoParams());

      // Assert
      expect(result, const Left(errorMessage));
    });
  });
}

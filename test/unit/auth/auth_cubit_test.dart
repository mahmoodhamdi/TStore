import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';
import 'package:t_store/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_state.dart';

// Mocks
class MockSignInUsecase extends Mock implements SignInUsecase {}

class MockSignUpUsecase extends Mock implements SignUpUsecase {}

class MockSignOutUsecase extends Mock implements SignOutUsecase {}

class MockResetPasswordUsecase extends Mock implements ResetPasswordUsecase {}

class MockGetCurrentUserUsecase extends Mock implements GetCurrentUserUsecase {}

// Fake classes for registerFallbackValue
class FakeSignInParams extends Fake implements SignInParams {}

class FakeSignUpParams extends Fake implements SignUpParams {}

class FakeNoParams extends Fake implements NoParams {}

void main() {
  late AuthCubit authCubit;
  late MockSignInUsecase mockSignInUsecase;
  late MockSignUpUsecase mockSignUpUsecase;
  late MockSignOutUsecase mockSignOutUsecase;
  late MockResetPasswordUsecase mockResetPasswordUsecase;
  late MockGetCurrentUserUsecase mockGetCurrentUserUsecase;

  setUpAll(() {
    registerFallbackValue(FakeSignInParams());
    registerFallbackValue(FakeSignUpParams());
    registerFallbackValue(FakeNoParams());
  });

  setUp(() {
    mockSignInUsecase = MockSignInUsecase();
    mockSignUpUsecase = MockSignUpUsecase();
    mockSignOutUsecase = MockSignOutUsecase();
    mockResetPasswordUsecase = MockResetPasswordUsecase();
    mockGetCurrentUserUsecase = MockGetCurrentUserUsecase();

    authCubit = AuthCubit(
      signInUsecase: mockSignInUsecase,
      signUpUsecase: mockSignUpUsecase,
      signOutUsecase: mockSignOutUsecase,
      resetPasswordUsecase: mockResetPasswordUsecase,
      getCurrentUserUsecase: mockGetCurrentUserUsecase,
    );
  });

  tearDown(() {
    authCubit.close();
  });

  // Test data
  const testEmail = 'test@example.com';
  const testPassword = 'password123';
  const testFullName = 'Test User';
  final testUser = UserEntity(
    id: 'test-id',
    email: testEmail,
    fullName: testFullName,
  );

  group('AuthCubit', () {
    test('initial state is AuthInitial', () {
      expect(authCubit.state, AuthInitial());
    });

    group('checkAuthStatus', () {
      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when user is logged in',
        build: () {
          when(() => mockGetCurrentUserUsecase(any()))
              .thenAnswer((_) async => Right(testUser));
          return authCubit;
        },
        act: (cubit) => cubit.checkAuthStatus(),
        expect: () => [
          AuthLoading(),
          AuthAuthenticated(testUser),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when no user is logged in',
        build: () {
          when(() => mockGetCurrentUserUsecase(any()))
              .thenAnswer((_) async => const Right(null));
          return authCubit;
        },
        act: (cubit) => cubit.checkAuthStatus(),
        expect: () => [
          AuthLoading(),
          AuthUnauthenticated(),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when fetching user fails',
        build: () {
          when(() => mockGetCurrentUserUsecase(any()))
              .thenAnswer((_) async => const Left('Error'));
          return authCubit;
        },
        act: (cubit) => cubit.checkAuthStatus(),
        expect: () => [
          AuthLoading(),
          AuthUnauthenticated(),
        ],
      );
    });

    group('signIn', () {
      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthAuthenticated] when sign in succeeds',
        build: () {
          when(() => mockSignInUsecase(any()))
              .thenAnswer((_) async => Right(testUser));
          return authCubit;
        },
        act: (cubit) => cubit.signIn(email: testEmail, password: testPassword),
        expect: () => [
          AuthLoading(),
          AuthAuthenticated(testUser),
        ],
        verify: (_) {
          verify(() => mockSignInUsecase(any())).called(1);
        },
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthError] when sign in fails',
        build: () {
          when(() => mockSignInUsecase(any()))
              .thenAnswer((_) async => const Left('Invalid credentials'));
          return authCubit;
        },
        act: (cubit) => cubit.signIn(email: testEmail, password: testPassword),
        expect: () => [
          AuthLoading(),
          const AuthError('Invalid credentials'),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthEmailConfirmationRequired] when email not confirmed',
        build: () {
          when(() => mockSignInUsecase(any())).thenAnswer(
              (_) async => const Left('يرجى تأكيد بريدك الإلكتروني'));
          return authCubit;
        },
        act: (cubit) => cubit.signIn(email: testEmail, password: testPassword),
        expect: () => [
          AuthLoading(),
          const AuthEmailConfirmationRequired(testEmail),
        ],
      );
    });

    group('signUp', () {
      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthEmailConfirmationRequired] when sign up succeeds',
        build: () {
          when(() => mockSignUpUsecase(any()))
              .thenAnswer((_) async => Right(testUser));
          return authCubit;
        },
        act: (cubit) => cubit.signUp(
          email: testEmail,
          password: testPassword,
          fullName: testFullName,
        ),
        expect: () => [
          AuthLoading(),
          const AuthEmailConfirmationRequired(testEmail),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthError] when sign up fails',
        build: () {
          when(() => mockSignUpUsecase(any()))
              .thenAnswer((_) async => const Left('Email already registered'));
          return authCubit;
        },
        act: (cubit) => cubit.signUp(
          email: testEmail,
          password: testPassword,
          fullName: testFullName,
        ),
        expect: () => [
          AuthLoading(),
          const AuthError('Email already registered'),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'passes phone to usecase when provided',
        build: () {
          when(() => mockSignUpUsecase(any()))
              .thenAnswer((_) async => Right(testUser));
          return authCubit;
        },
        act: (cubit) => cubit.signUp(
          email: testEmail,
          password: testPassword,
          fullName: testFullName,
          phone: '+1234567890',
        ),
        verify: (_) {
          final captured = verify(() => mockSignUpUsecase(captureAny()))
              .captured
              .first as SignUpParams;
          expect(captured.phone, '+1234567890');
        },
      );
    });

    group('signOut', () {
      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthUnauthenticated] when sign out succeeds',
        build: () {
          when(() => mockSignOutUsecase(any()))
              .thenAnswer((_) async => const Right(null));
          return authCubit;
        },
        act: (cubit) => cubit.signOut(),
        expect: () => [
          AuthLoading(),
          AuthUnauthenticated(),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthError] when sign out fails',
        build: () {
          when(() => mockSignOutUsecase(any()))
              .thenAnswer((_) async => const Left('Sign out failed'));
          return authCubit;
        },
        act: (cubit) => cubit.signOut(),
        expect: () => [
          AuthLoading(),
          const AuthError('Sign out failed'),
        ],
      );
    });

    group('resetPassword', () {
      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthPasswordResetSent] when reset password succeeds',
        build: () {
          when(() => mockResetPasswordUsecase(testEmail))
              .thenAnswer((_) async => const Right(null));
          return authCubit;
        },
        act: (cubit) => cubit.resetPassword(testEmail),
        expect: () => [
          AuthLoading(),
          const AuthPasswordResetSent(testEmail),
        ],
      );

      blocTest<AuthCubit, AuthState>(
        'emits [AuthLoading, AuthError] when reset password fails',
        build: () {
          when(() => mockResetPasswordUsecase(testEmail))
              .thenAnswer((_) async => const Left('Email not found'));
          return authCubit;
        },
        act: (cubit) => cubit.resetPassword(testEmail),
        expect: () => [
          AuthLoading(),
          const AuthError('Email not found'),
        ],
      );
    });

    group('clearError', () {
      blocTest<AuthCubit, AuthState>(
        'emits AuthUnauthenticated when current state is AuthError',
        build: () => authCubit,
        seed: () => const AuthError('Some error'),
        act: (cubit) => cubit.clearError(),
        expect: () => [AuthUnauthenticated()],
      );

      blocTest<AuthCubit, AuthState>(
        'does not emit when current state is not AuthError',
        build: () => authCubit,
        seed: () => AuthUnauthenticated(),
        act: (cubit) => cubit.clearError(),
        expect: () => [],
      );
    });
  });
}

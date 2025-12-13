import 'package:flutter_test/flutter_test.dart';
import 'package:dartz/dartz.dart';
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

// Fakes
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

  group('Auth Flow Integration', () {
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testFullName = 'Test User';

    final testUser = UserEntity(
      id: 'user-id-123',
      email: testEmail,
      fullName: testFullName,
    );

    group('Complete Sign Up Flow', () {
      test('user can sign up and receive email confirmation requirement',
          () async {
        // Arrange - Setup sign up to succeed
        when(() => mockSignUpUsecase(any()))
            .thenAnswer((_) async => Right(testUser));

        // Act
        await authCubit.signUp(
          email: testEmail,
          password: testPassword,
          fullName: testFullName,
        );

        // Assert - User should get email confirmation required state
        expect(authCubit.state, isA<AuthEmailConfirmationRequired>());
        final state = authCubit.state as AuthEmailConfirmationRequired;
        expect(state.email, testEmail);
      });
    });

    group('Complete Sign In Flow', () {
      test('user can sign in and become authenticated', () async {
        // Arrange
        when(() => mockSignInUsecase(any()))
            .thenAnswer((_) async => Right(testUser));

        // Act
        await authCubit.signIn(email: testEmail, password: testPassword);

        // Assert
        expect(authCubit.state, isA<AuthAuthenticated>());
        final state = authCubit.state as AuthAuthenticated;
        expect(state.user.email, testEmail);
        expect(state.user.fullName, testFullName);
      });

      test('user receives error state with invalid credentials', () async {
        // Arrange
        when(() => mockSignInUsecase(any())).thenAnswer(
            (_) async => const Left('البريد الإلكتروني أو كلمة المرور غير صحيحة'));

        // Act
        await authCubit.signIn(email: testEmail, password: 'wrong');

        // Assert
        expect(authCubit.state, isA<AuthError>());
        final state = authCubit.state as AuthError;
        expect(state.message, contains('غير صحيحة'));
      });

      test(
          'user receives email confirmation required when email not confirmed',
          () async {
        // Arrange
        when(() => mockSignInUsecase(any())).thenAnswer(
            (_) async => const Left('يرجى تأكيد بريدك الإلكتروني أولاً'));

        // Act
        await authCubit.signIn(email: testEmail, password: testPassword);

        // Assert
        expect(authCubit.state, isA<AuthEmailConfirmationRequired>());
      });
    });

    group('Complete Sign Out Flow', () {
      test('authenticated user can sign out', () async {
        // Arrange - First sign in
        when(() => mockSignInUsecase(any()))
            .thenAnswer((_) async => Right(testUser));
        when(() => mockSignOutUsecase(any()))
            .thenAnswer((_) async => const Right(null));

        // Act - Sign in first
        await authCubit.signIn(email: testEmail, password: testPassword);
        expect(authCubit.state, isA<AuthAuthenticated>());

        // Act - Then sign out
        await authCubit.signOut();

        // Assert
        expect(authCubit.state, isA<AuthUnauthenticated>());
      });
    });

    group('Password Reset Flow', () {
      test('user can request password reset', () async {
        // Arrange
        when(() => mockResetPasswordUsecase(testEmail))
            .thenAnswer((_) async => const Right(null));

        // Act
        await authCubit.resetPassword(testEmail);

        // Assert
        expect(authCubit.state, isA<AuthPasswordResetSent>());
        final state = authCubit.state as AuthPasswordResetSent;
        expect(state.email, testEmail);
      });

      test('user receives error when rate limited', () async {
        // Arrange
        when(() => mockResetPasswordUsecase(testEmail)).thenAnswer((_) async =>
            const Left('تم تجاوز عدد المحاولات المسموحة. يرجى المحاولة لاحقاً'));

        // Act
        await authCubit.resetPassword(testEmail);

        // Assert
        expect(authCubit.state, isA<AuthError>());
        final state = authCubit.state as AuthError;
        expect(state.message, contains('المحاولات المسموحة'));
      });
    });

    group('Auth Status Check Flow', () {
      test('returns authenticated when user is logged in', () async {
        // Arrange
        when(() => mockGetCurrentUserUsecase(any()))
            .thenAnswer((_) async => Right(testUser));

        // Act
        await authCubit.checkAuthStatus();

        // Assert
        expect(authCubit.state, isA<AuthAuthenticated>());
      });

      test('returns unauthenticated when no user logged in', () async {
        // Arrange
        when(() => mockGetCurrentUserUsecase(any()))
            .thenAnswer((_) async => const Right(null));

        // Act
        await authCubit.checkAuthStatus();

        // Assert
        expect(authCubit.state, isA<AuthUnauthenticated>());
      });

      test('returns unauthenticated on error', () async {
        // Arrange
        when(() => mockGetCurrentUserUsecase(any()))
            .thenAnswer((_) async => const Left('Session expired'));

        // Act
        await authCubit.checkAuthStatus();

        // Assert
        expect(authCubit.state, isA<AuthUnauthenticated>());
      });
    });

    group('Error Recovery Flow', () {
      test('user can clear error and return to unauthenticated state',
          () async {
        // Arrange - Get into error state
        when(() => mockSignInUsecase(any()))
            .thenAnswer((_) async => const Left('Some error'));

        await authCubit.signIn(email: testEmail, password: 'wrong');
        expect(authCubit.state, isA<AuthError>());

        // Act
        authCubit.clearError();

        // Assert
        expect(authCubit.state, isA<AuthUnauthenticated>());
      });
    });
  });
}

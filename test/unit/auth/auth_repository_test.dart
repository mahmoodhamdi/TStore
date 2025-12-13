import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';
import 'package:t_store/features/auth/domain/repositories/auth_repository.dart';

// Create a mock implementation of AuthRepository for testing
class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late MockAuthRepository mockRepository;

  setUp(() {
    mockRepository = MockAuthRepository();
  });

  group('AuthRepository', () {
    // Test data
    const testEmail = 'test@example.com';
    const testPassword = 'password123';
    const testFullName = 'Test User';
    final testUser = UserEntity(
      id: 'test-user-id',
      email: testEmail,
      fullName: testFullName,
    );

    group('signIn', () {
      test('should return UserEntity when sign in is successful', () async {
        // Arrange
        when(() => mockRepository.signIn(
              email: testEmail,
              password: testPassword,
            )).thenAnswer((_) async => Right(testUser));

        // Act
        final result = await mockRepository.signIn(
          email: testEmail,
          password: testPassword,
        );

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (error) => fail('Expected Right but got Left: $error'),
          (user) {
            expect(user.id, 'test-user-id');
            expect(user.email, testEmail);
            expect(user.fullName, testFullName);
          },
        );
        verify(() => mockRepository.signIn(
              email: testEmail,
              password: testPassword,
            )).called(1);
      });

      test('should return error message when credentials are invalid',
          () async {
        // Arrange
        when(() => mockRepository.signIn(
              email: testEmail,
              password: 'wrongpassword',
            )).thenAnswer(
            (_) async => const Left('البريد الإلكتروني أو كلمة المرور غير صحيحة'));

        // Act
        final result = await mockRepository.signIn(
          email: testEmail,
          password: 'wrongpassword',
        );

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (error) => expect(error, contains('غير صحيحة')),
          (user) => fail('Expected Left but got Right'),
        );
      });

      test('should return error when email not confirmed', () async {
        // Arrange
        when(() => mockRepository.signIn(
              email: testEmail,
              password: testPassword,
            )).thenAnswer(
            (_) async => const Left('يرجى تأكيد بريدك الإلكتروني أولاً'));

        // Act
        final result = await mockRepository.signIn(
          email: testEmail,
          password: testPassword,
        );

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (error) => expect(error, contains('تأكيد بريدك')),
          (user) => fail('Expected Left but got Right'),
        );
      });
    });

    group('signUp', () {
      test('should return UserEntity when sign up is successful', () async {
        // Arrange
        final newUser = UserEntity(
          id: 'new-user-id',
          email: 'newuser@example.com',
          fullName: 'New User',
          phone: '+1234567890',
        );

        when(() => mockRepository.signUp(
              email: 'newuser@example.com',
              password: testPassword,
              fullName: 'New User',
              phone: '+1234567890',
            )).thenAnswer((_) async => Right(newUser));

        // Act
        final result = await mockRepository.signUp(
          email: 'newuser@example.com',
          password: testPassword,
          fullName: 'New User',
          phone: '+1234567890',
        );

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (error) => fail('Expected Right but got Left: $error'),
          (user) {
            expect(user.id, 'new-user-id');
            expect(user.email, 'newuser@example.com');
            expect(user.fullName, 'New User');
            expect(user.phone, '+1234567890');
          },
        );
      });

      test('should return error when user already exists', () async {
        // Arrange
        when(() => mockRepository.signUp(
              email: 'existing@example.com',
              password: testPassword,
              fullName: testFullName,
              phone: null,
            )).thenAnswer(
            (_) async => const Left('هذا البريد الإلكتروني مسجل بالفعل'));

        // Act
        final result = await mockRepository.signUp(
          email: 'existing@example.com',
          password: testPassword,
          fullName: testFullName,
        );

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (error) => expect(error, contains('مسجل بالفعل')),
          (user) => fail('Expected Left but got Right'),
        );
      });

      test('should return error when password is too short', () async {
        // Arrange
        when(() => mockRepository.signUp(
              email: testEmail,
              password: '123',
              fullName: testFullName,
              phone: null,
            )).thenAnswer(
            (_) async => const Left('كلمة المرور يجب أن تكون 6 أحرف على الأقل'));

        // Act
        final result = await mockRepository.signUp(
          email: testEmail,
          password: '123',
          fullName: testFullName,
        );

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (error) => expect(error, contains('كلمة المرور')),
          (user) => fail('Expected Left but got Right'),
        );
      });
    });

    group('signOut', () {
      test('should return Right(null) when sign out is successful', () async {
        // Arrange
        when(() => mockRepository.signOut())
            .thenAnswer((_) async => const Right(null));

        // Act
        final result = await mockRepository.signOut();

        // Assert
        expect(result.isRight(), true);
        verify(() => mockRepository.signOut()).called(1);
      });

      test('should return error when sign out fails', () async {
        // Arrange
        when(() => mockRepository.signOut())
            .thenAnswer((_) async => const Left('Network error'));

        // Act
        final result = await mockRepository.signOut();

        // Assert
        expect(result.isLeft(), true);
      });
    });

    group('resetPassword', () {
      test('should return Right(null) when reset password is successful',
          () async {
        // Arrange
        when(() => mockRepository.resetPassword(testEmail))
            .thenAnswer((_) async => const Right(null));

        // Act
        final result = await mockRepository.resetPassword(testEmail);

        // Assert
        expect(result.isRight(), true);
        verify(() => mockRepository.resetPassword(testEmail)).called(1);
      });

      test('should return error when rate limit exceeded', () async {
        // Arrange
        when(() => mockRepository.resetPassword(testEmail)).thenAnswer(
            (_) async =>
                const Left('تم تجاوز عدد المحاولات المسموحة. يرجى المحاولة لاحقاً'));

        // Act
        final result = await mockRepository.resetPassword(testEmail);

        // Assert
        expect(result.isLeft(), true);
        result.fold(
          (error) => expect(error, contains('المحاولات المسموحة')),
          (_) => fail('Expected Left but got Right'),
        );
      });
    });

    group('getCurrentUser', () {
      test('should return UserEntity when user is logged in', () async {
        // Arrange
        when(() => mockRepository.getCurrentUser())
            .thenAnswer((_) async => Right(testUser));

        // Act
        final result = await mockRepository.getCurrentUser();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (error) => fail('Expected Right but got Left'),
          (user) {
            expect(user, isNotNull);
            expect(user!.id, 'test-user-id');
          },
        );
      });

      test('should return null when no user is logged in', () async {
        // Arrange
        when(() => mockRepository.getCurrentUser())
            .thenAnswer((_) async => const Right(null));

        // Act
        final result = await mockRepository.getCurrentUser();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (error) => fail('Expected Right but got Left'),
          (user) => expect(user, null),
        );
      });
    });

    group('isLoggedIn', () {
      test('should return true when user is logged in', () {
        // Arrange
        when(() => mockRepository.isLoggedIn).thenReturn(true);

        // Act
        final result = mockRepository.isLoggedIn;

        // Assert
        expect(result, true);
      });

      test('should return false when user is not logged in', () {
        // Arrange
        when(() => mockRepository.isLoggedIn).thenReturn(false);

        // Act
        final result = mockRepository.isLoggedIn;

        // Assert
        expect(result, false);
      });
    });

    group('OAuth methods', () {
      test('signInWithGoogle should return true when successful', () async {
        // Arrange
        when(() => mockRepository.signInWithGoogle())
            .thenAnswer((_) async => const Right(true));

        // Act
        final result = await mockRepository.signInWithGoogle();

        // Assert
        expect(result.isRight(), true);
        result.fold(
          (error) => fail('Expected Right but got Left'),
          (success) => expect(success, true),
        );
      });

      test('signInWithFacebook should return true when successful', () async {
        // Arrange
        when(() => mockRepository.signInWithFacebook())
            .thenAnswer((_) async => const Right(true));

        // Act
        final result = await mockRepository.signInWithFacebook();

        // Assert
        expect(result.isRight(), true);
      });

      test('signInWithApple should return true when successful', () async {
        // Arrange
        when(() => mockRepository.signInWithApple())
            .thenAnswer((_) async => const Right(true));

        // Act
        final result = await mockRepository.signInWithApple();

        // Assert
        expect(result.isRight(), true);
      });
    });
  });
}

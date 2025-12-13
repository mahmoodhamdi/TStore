import 'package:dartz/dartz.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  /// Get current user
  Future<Either<String, UserEntity?>> getCurrentUser();

  /// Sign in with email and password
  Future<Either<String, UserEntity>> signIn({
    required String email,
    required String password,
  });

  /// Sign up with email and password
  Future<Either<String, UserEntity>> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  });

  /// Sign in with Google
  Future<Either<String, bool>> signInWithGoogle();

  /// Sign in with Facebook
  Future<Either<String, bool>> signInWithFacebook();

  /// Sign in with Apple
  Future<Either<String, bool>> signInWithApple();

  /// Sign out
  Future<Either<String, void>> signOut();

  /// Reset password
  Future<Either<String, void>> resetPassword(String email);

  /// Update password
  Future<Either<String, void>> updatePassword(String newPassword);

  /// Resend confirmation email
  Future<Either<String, void>> resendConfirmation(String email);

  /// Check if user is logged in
  bool get isLoggedIn;

  /// Auth state changes stream
  Stream<UserEntity?> get authStateChanges;
}

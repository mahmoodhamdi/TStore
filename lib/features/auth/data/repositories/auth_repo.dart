import 'package:t_store/features/auth/presentation/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/presentation/models/auth_register_model.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';

abstract class AuthRepo {
  // Method to sign up with email
  Future<void> signUpWithEmail({required AuthRegisterModel authRegisterModel});

  // Method to send verification email
  Future<void> sendVerificationEmail();
// method to check if the user is verified
  Future<bool> isVerified();
  // Method to send reset password email
  Future<void> sendResetPasswordEmail({required String email});
  // Method to log in with email
  Future<void> loginWithEmail(
      {required AuthLoginWithEmailModel authLoginWithEmailModel});

  // Method to sign in with Google
  Future<void> signInWithGoogle();

  // Method to log out
  Future<void> logout();
  // Method to delete account
  Future<void> deleteAccount();
  // Method to fetch user data
  Future<UserModel?> fetchUserData();
}

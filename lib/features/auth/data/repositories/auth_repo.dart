import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/features/auth/presentation/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/presentation/models/auth_register_model.dart';

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
  Future<UserCredential> signInWithGoogle();

  // Method to sign in with Facebook
  Future<UserCredential> signInWithFacebook();

  
  // Method to log out
  Future<void> logout();
}

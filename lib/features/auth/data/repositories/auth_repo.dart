import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/features/auth/data/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/data/models/auth_register_model.dart';

abstract class AuthRepo {
  User? get currentUser;
  // Method to sign up with email
  Future<void> signUpWithEmail({required AuthRegisterModel authRegisterModel});

  // Method to send verification email
  Future<void> sendVerificationEmail();
// method to check if the user is verified
  bool isVerified();
  // Method to sign up with Google
  Future<void> signUpWithGoogle();

  // Method to log in with email
  Future<void> loginWithEmail(
      {required AuthLoginWithEmailModel authLoginWithEmailModel});

  // Method to sign in with Google
  Future<void> signInWithGoogle();

  // Method to sign in with Facebook
  Future<void> signInWithFacebook();

  // Method to reset password
  Future<void> forgetPassword({required String email});

  // Method to log out
  Future<void> logout();
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:t_store/features/auth/data/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/data/models/auth_register_model.dart';

abstract class AuthRepo {
  Future<void> signUpWithEmail(
      {required AuthRegisterModel authRegisterModel});
  Future<void> sendVerificationEmail(
    User? user,
  );
  Future<void> signUpWithGoogle();
  Future<void> loginWithEmail(
      {required  AuthLoginWithEmailModel authLoginWithEmailModel});
  Future<void> signInWithGoogle();
  Future<void> signInWithFacebook();
  Future<void> forgetPassword({required String email});
  Future<void> logout();
}

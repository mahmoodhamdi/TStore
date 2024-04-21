import 'package:t_store/features/auth/presentation/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/presentation/models/auth_register_model.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';

abstract class AuthRepo {
  // Method to sign up with email
  Future<void> signUpWithEmail({required AuthRegisterModel authRegisterModel});

  Future<void> sendVerificationEmail();
  Future<bool> isVerified();
  Future<void> sendResetPasswordEmail({required String email});
  Future<void> loginWithEmail(
      {required AuthLoginWithEmailModel authLoginWithEmailModel});

  Future<void> signInWithGoogle();

  Future<void> logout();
  Future<void> deleteAccount();
   Future<UserModel?> fetchUserData();
  Future<void> uploadImage();
  Future<UserModel> updateUserData(UserModel userModel);
  Future<void> saveUserData(UserModel userModel);
  Future<void> deleteUserData(String userId);
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/features/auth/data/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/data/models/auth_register_model.dart';
import 'package:t_store/features/auth/data/repositories/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _firebaseAuth;

  AuthRepoImpl() : _firebaseAuth = FirebaseAuth.instance;

  @override
  Future<void> signUpWithEmail(
      {required AuthRegisterModel authRegisterModel}) async {
    try {
      // Your sign up with email logic here

      await _firebaseAuth.createUserWithEmailAndPassword(
        email: authRegisterModel.email,
        password: authRegisterModel.password,
      );
      
      await sendVerificationEmail(_firebaseAuth.currentUser);
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("Sign up with email failed: $e");
      }
      throw TFirebaseAuthException(e.code);
    } catch (e) {
      if (kDebugMode) {
        print("Sign up with email failed: $e");
      }
    }
  }

  @override
  Future<void> sendVerificationEmail(
    User? user,
  ) async {
    try {
      if (user != null) {
        await user.sendEmailVerification();
      }
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } catch (e) {
      if (kDebugMode) {
        print("Send verification email failed: $e");
      }
    }
  }

  @override
  Future<void> signUpWithGoogle() async {
    try {
      // Your sign up with Google logic here using GoogleSignIn and FirebaseAuth
    } catch (e) {
      throw Exception("Sign up with Google failed: $e");
    }
  }

  @override
  Future<void> loginWithEmail(
      {required AuthLoginWithEmailModel authLoginWithEmailModel}) async {
    try {
      // Your login with email logic here
      await _firebaseAuth.signInWithEmailAndPassword(
          email: authLoginWithEmailModel.email,
          password: authLoginWithEmailModel.password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } catch (e) {
      if (kDebugMode) {
        print("Login with email failed: $e");
      }
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      // Your sign in with Google logic here using GoogleSignIn and FirebaseAuth
    } catch (e) {
      throw Exception("Sign in with Google failed: $e");
    }
  }

  @override
  Future<void> signInWithFacebook() async {
    try {
      // Your sign in with Facebook logic here
    } catch (e) {
      throw Exception("Sign in with Facebook failed: $e");
    }
  }

  @override
  Future<void> forgetPassword({required String email}) async {
    try {
      // Your forget password logic here using _firebaseAuth
    } catch (e) {
      throw Exception("Forget password failed: $e");
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Your logout logic here
      await _firebaseAuth.signOut();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } catch (e) {
      if (kDebugMode) {
        print("Logout failed: $e");
      }
    }
  }
}

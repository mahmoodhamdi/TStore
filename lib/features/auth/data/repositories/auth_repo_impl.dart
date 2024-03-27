import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/core/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/features/auth/data/repositories/auth_repo.dart';
import 'package:t_store/features/auth/presentation/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/presentation/models/auth_register_model.dart';

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
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("Platform exception: $e");
      }
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      // Handle sign up with email exceptions
      if (kDebugMode) {
        print("Sign up with email failed: $e");
      }
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase exception: $e");
      }
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("Exceptions: $e");
      }
      throw TExceptions(e.message).message;
    } catch (e) {
      if (kDebugMode) {
        print("Sign up with email failed: $e");
      }
    }
  }

  @override
  Future<bool> isVerified() async {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      await currentUser?.reload();
      return currentUser?.emailVerified ?? false;
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code);
    } catch (e) {
      if (kDebugMode) {
        print("Check verification failed: $e");
      }
      throw Exception("Check verification failed: $e");
    }
  }

  @override
  Future<void> sendVerificationEmail() async {
    try {
      // Your send verification email logic here
      await _firebaseAuth.currentUser?.sendEmailVerification();
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("Platform exception: $e");
      }
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      // Handle sign up with email exceptions
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase exception: $e");
      }
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("Exceptions: $e");
      }
      throw TExceptions(e.message).message;
    } catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
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
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("Platform exception: $e");
      }
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      // Handle sign up with email exceptions
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase exception: $e");
      }
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("Exceptions: $e");
      }
      throw TExceptions(e.message).message;
    } catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Your logout logic here
      await _firebaseAuth.signOut();
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("Platform exception: $e");
      }
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      // Handle sign up with email exceptions
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase exception: $e");
      }
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("Exceptions: $e");
      }
      throw TExceptions(e.message).message;
    } catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
    }
  }

  @override
  Future<UserCredential> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      return await FirebaseAuth.instance.signInWithCredential(credential);
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("Platform exception: $e");
      }
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      // Handle sign up with email exceptions
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase exception: $e");
      }
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("Exceptions: $e");
      }
      throw TExceptions(e.message).message;
    }
  }

  @override
  Future<void> forgetPassword({required String email}) async {
    try {
      // Your forget password logic here using _firebaseAuth
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("Platform exception: $e");
      }
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      // Handle sign up with email exceptions
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase exception: $e");
      }
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("Exceptions: $e");
      }
      throw TExceptions(e.message).message;
    } catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
    }
  }

  @override
  Future<UserCredential> signInWithFacebook() async {
    try {
      // Trigger the Facebook sign-in flow
      final LoginResult result = await FacebookAuth.instance.login();

      // Check if the user successfully signed in
      if (result.status == LoginStatus.success) {
        // Get the access token from the result
        final AccessToken? accessToken = result.accessToken;

        // Convert the Facebook access token to a Firebase credential
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken!.token);

        // Sign in to Firebase with the Facebook credential
        return await _firebaseAuth.signInWithCredential(credential);
      } else {
        // Handle sign-in failure
        throw FirebaseAuthException(
          code: 'sign_in_failed',
          message: 'Failed to sign in with Facebook: ${result.status}',
        );
      }
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("Platform exception: $e");
      }
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      // Handle sign up with email exceptions
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase exception: $e");
      }
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("Exceptions: $e");
      }
      throw TExceptions(e.message).message;
    }
  }
}

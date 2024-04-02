import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/core/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/core/utils/logging/logger.dart';
import 'package:t_store/features/auth/data/repositories/auth_repo.dart';
import 'package:t_store/features/auth/presentation/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/presentation/models/auth_register_model.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';
import 'package:t_store/features/personalization/data/repositories/user_repo.dart';

class AuthRepoImpl implements AuthRepo {
  final FirebaseAuth _firebaseAuth;
  final UserRepo _userRepo; // Inject UserRepo

  AuthRepoImpl(this._userRepo) : _firebaseAuth = FirebaseAuth.instance;
  @override
  Future<void> signUpWithEmail(
      {required AuthRegisterModel authRegisterModel}) async {
    try {
      // Your sign up with email logic here
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: authRegisterModel.email,
        password: authRegisterModel.password,
      );

      // After successful sign-up, retrieve the user object
      User? user = _firebaseAuth.currentUser;

      if (user != null) {
        // Wait for the user data to become available
        await user.reload();

        // Retrieve the updated user object to ensure that all data is available
        user = _firebaseAuth.currentUser;

        // Construct the user model with available user data
        UserModel userModel = UserModel(
          email: authRegisterModel.email,
          username: authRegisterModel.username,
          emailVerified: user!.emailVerified,
          firstName: authRegisterModel.firstName,
          lastName: authRegisterModel.lastName,
          phoneNumber: authRegisterModel.phoneNo,
          id: user.uid,
          // Add other properties as needed
        );

        // Save user data to Firestore
        await _userRepo.saveUserData(userModel);
      }
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      throw TExceptions(e.message).message;
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<bool> isVerified() async {
    try {
      User? currentUser = _firebaseAuth.currentUser;
      await currentUser?.reload();
      return currentUser?.emailVerified ?? false;
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      throw TExceptions(e.message).message;
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> sendVerificationEmail() async {
    try {
      // Your send verification email logic here
      await _firebaseAuth.currentUser?.sendEmailVerification();
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      throw TExceptions(e.message).message;
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> sendResetPasswordEmail({required String email}) async {
    try {
      // Your send verification email logic here
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      throw TExceptions(e.message).message;
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      throw Exception(e.toString());
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
      // After successful sign-in, retrieve user information and store it
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        // Wait for the user data to become available
        await user.reload();

        // Retrieve the updated user object to ensure that all data is available
        user = _firebaseAuth.currentUser;
        UserModel userModel = UserModel(
          email: authLoginWithEmailModel.email,
          username: user!.providerData[0].displayName!,
          emailVerified: user.emailVerified,
          id: user.uid,
        );
        await _userRepo.saveUserData(userModel); // Save user data to Firestore
      }
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      throw TExceptions(e.message).message;
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Your logout logic here
      await _firebaseAuth.signOut();
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      throw TExceptions(e.message).message;
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );

      await _firebaseAuth.signInWithCredential(credential);
      // After successful sign-in, retrieve user information and store it
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        UserModel userModel = UserModel(
          email: user.providerData[0].email!,
          username: user.providerData[0].displayName!,
          image: user.providerData[0].photoURL,
          emailVerified: user.emailVerified,
          firstName: user.providerData[0].displayName!.split(" ")[0],
          lastName: user.providerData[0].displayName!.split(" ")[1],
          phoneNumber: user.providerData[0].phoneNumber,
          id: user.uid,
          // Add other user information if needed
        );
        await _userRepo.saveUserData(userModel); // Save user data to Firestore
      }
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      throw TExceptions(e.message).message;
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      throw Exception(e.toString());
    }
  }

  @override
  Future<void> deleteAccount() async {
    try {
      await _firebaseAuth.currentUser?.delete();
      User? user = _firebaseAuth.currentUser;
      if (user != null) {
        await _userRepo.deleteUserData(user.uid);
      }
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      throw TExceptions(e.message).message;
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      throw Exception(e.toString());
    }
  }
}

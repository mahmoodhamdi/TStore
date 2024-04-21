// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/core/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/utils/logging/logger.dart';
import 'package:t_store/features/auth/data/repositories/auth_repo.dart';
import 'package:t_store/features/auth/presentation/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/presentation/models/auth_register_model.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  bool obscureText = true;
  UserModel? userModel;
  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<bool> checkConnection(BuildContext context) async {
    bool connected = await THelperFunctions.isConnected();
    if (!connected) {
      emit(AuthNotConnected());
      return false;
    }
    return true;
  }

  void togglePasswordVisibility() {
    obscureText = !obscureText;
  }

  Future<void> signUpWithEmail(
      {required AuthRegisterModel authRegisterModel}) async {
    try {
      emit(AuthSigningUpWithEmail());
      await _authRepo.signUpWithEmail(authRegisterModel: authRegisterModel);

      emit(AuthSignedUpWithEmail(authRegisterModel: authRegisterModel));
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      emit(AuthSendingVerifyingEmail());
      await _authRepo.sendVerificationEmail();
      emit(AuthVerifyingEmailSent());
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  void isVerified() async {
    try {
      bool verified = await _authRepo.isVerified();
      if (verified) {
        emit(AuthVerifiedEmail());
      } else {
        emit(AuthUnverifiedEmail());

        isVerified();
      }
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> loginWithEmail(
      {required AuthLoginWithEmailModel authLoginWithEmailModel}) async {
    try {
      emit(AuthLoggingInWithEmail());
      await _authRepo.loginWithEmail(
          authLoginWithEmailModel: authLoginWithEmailModel);

      await fetchUserData();

      emit(AuthLoggedInWithEmail());
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthSigningInWithGoogle());
      await _authRepo.signInWithGoogle();
      await fetchUserData();
      emit(AuthSignedInWithGoogle());
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> sendResetPasswordEmail({required String email}) async {
    try {
      emit(AuthForgettingPassword());
      await _authRepo.sendResetPasswordEmail(email: email);
      emit(AuthPasswordReset());
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoggingOut());
      await _authRepo.logout();

      emit(AuthLoggedOut());
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> deleteAccount() async {
    try {
      emit(AuthDeletingAccount());
      await _authRepo.deleteAccount();
      emit(AuthDeletedAccount());
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> fetchUserData() async {
    try {
      emit(AuthFetchingUserData());
      userModel = await _authRepo.fetchUserData();
      if (userModel != null) {
        emit(AuthFetchedUserData(
          userModel: userModel!,
        ));
      } else {
        emit(const AuthError(message: "User not found"));
      }
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> saveUserData(UserModel userModel) async {
    try {
      emit(AuthSavingUserData());
      await _authRepo.saveUserData(userModel);
      emit(
          AuthSavedUserData()); // Emit a state to indicate successful user data saving
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> uploadImage() async {
    try {
      emit(AuthImageUploading());
      await _authRepo.uploadImage();
      await fetchUserData();
      TLoggerHelper.info("UserModel: $userModel");
      emit(AuthImageUploaded());
    } on TFirebaseAuthException catch (e) {
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(AuthError(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(AuthError(message: e.toString()));
    }
  }
}

// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/core/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/data/repositories/auth_repo.dart';
import 'package:t_store/features/auth/presentation/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/presentation/models/auth_register_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;
  bool obscureText = true;
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
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("platform exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("firebase exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> sendVerificationEmail() async {
    try {
      emit(AuthSendingVerifyingEmail());
      await _authRepo.sendVerificationEmail();
      emit(AuthVerifyingEmailSent());
    } on TFirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("platform exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("firebase exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
      emit(AuthError(message: e.message));
    } catch (e) {
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
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("platform exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("firebase exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> loginWithEmail(
      {required AuthLoginWithEmailModel authLoginWithEmailModel}) async {
    try {
      emit(AuthLoggingInWithEmail());
      await _authRepo.loginWithEmail(
          authLoginWithEmailModel: authLoginWithEmailModel);
      emit(AuthLoggedInWithEmail());
    } on TFirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("platform exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("firebase exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthSigningInWithGoogle());
      await _authRepo.signInWithGoogle();
      emit(AuthSignedInWithGoogle());
    } on TFirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("platform exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("firebase exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      emit(AuthSigningInWithFacebook());
      await _authRepo.signInWithFacebook();
      emit(AuthSignedInWithFacebook());
    } on TFirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("platform exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("firebase exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> sendResetPasswordEmail({required String email}) async {
    try {
      emit(AuthForgettingPassword());
      await _authRepo.sendResetPasswordEmail(email: email);
      emit(AuthPasswordReset());
    } on TFirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("platform exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("firebase exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoggingOut());
      await _authRepo.logout();

      emit(AuthLoggedOut());
    } on TFirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("platform exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("firebase exception: $e");
      }
      emit(AuthError(message: e.message));
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
      emit(AuthError(message: e.message));
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}

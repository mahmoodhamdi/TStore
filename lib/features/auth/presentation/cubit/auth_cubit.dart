// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:t_store/features/auth/data/models/auth_login_with_email_model.dart';
import 'package:t_store/features/auth/data/models/auth_register_model.dart';
import 'package:t_store/features/auth/data/repositories/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepo _authRepo;

  AuthCubit(this._authRepo) : super(AuthInitial());

  Future<void> signUpWithEmail({required AuthRegisterModel authRegisterModel}) async {
    try {
    
      emit(AuthSigningUpWithEmail());
      await _authRepo.signUpWithEmail(authRegisterModel: authRegisterModel);
         emit(AuthSignedUpWithEmail());

    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signUpWithGoogle() async {
    try {
      emit(AuthSigningUpWithGoogle());
      await _authRepo.signUpWithGoogle();
      emit(AuthSignedUpWithGoogle());
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
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      emit(AuthSigningInWithGoogle());
      await _authRepo.signInWithGoogle();
      emit(AuthSignedInWithGoogle());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      emit(AuthSigningInWithFacebook());
      await _authRepo.signInWithFacebook();
      emit(AuthSignedInWithFacebook());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> forgetPassword({required String email}) async {
    try {
      emit(AuthForgettingPassword());
      await _authRepo.forgetPassword(email: email);
      emit(AuthPasswordReset());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }

  Future<void> logout() async {
    try {
      emit(AuthLoggingOut());
      await _authRepo.logout();
      emit(AuthLoggedOut());
    } catch (e) {
      emit(AuthError(message: e.toString()));
    }
  }
}

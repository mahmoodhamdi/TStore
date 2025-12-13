import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final SignInUsecase signInUsecase;
  final SignUpUsecase signUpUsecase;
  final SignOutUsecase signOutUsecase;
  final ResetPasswordUsecase resetPasswordUsecase;
  final GetCurrentUserUsecase getCurrentUserUsecase;

  AuthCubit({
    required this.signInUsecase,
    required this.signUpUsecase,
    required this.signOutUsecase,
    required this.resetPasswordUsecase,
    required this.getCurrentUserUsecase,
  }) : super(AuthInitial());

  Future<void> checkAuthStatus() async {
    emit(AuthLoading());

    final result = await getCurrentUserUsecase(const NoParams());

    result.fold(
      (error) => emit(AuthUnauthenticated()),
      (user) {
        if (user != null) {
          emit(AuthAuthenticated(user));
        } else {
          emit(AuthUnauthenticated());
        }
      },
    );
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    emit(AuthLoading());

    final result = await signInUsecase(SignInParams(
      email: email,
      password: password,
    ));

    result.fold(
      (error) {
        if (error.contains('تأكيد بريدك')) {
          emit(AuthEmailConfirmationRequired(email));
        } else {
          emit(AuthError(error));
        }
      },
      (user) => emit(AuthAuthenticated(user)),
    );
  }

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    String? phone,
  }) async {
    emit(AuthLoading());

    final result = await signUpUsecase(SignUpParams(
      email: email,
      password: password,
      fullName: fullName,
      phone: phone,
    ));

    result.fold(
      (error) => emit(AuthError(error)),
      (user) => emit(AuthEmailConfirmationRequired(email)),
    );
  }

  Future<void> signOut() async {
    emit(AuthLoading());

    final result = await signOutUsecase(const NoParams());

    result.fold(
      (error) => emit(AuthError(error)),
      (_) => emit(AuthUnauthenticated()),
    );
  }

  Future<void> resetPassword(String email) async {
    emit(AuthLoading());

    final result = await resetPasswordUsecase(email);

    result.fold(
      (error) => emit(AuthError(error)),
      (_) => emit(AuthPasswordResetSent(email)),
    );
  }

  void clearError() {
    if (state is AuthError) {
      emit(AuthUnauthenticated());
    }
  }
}

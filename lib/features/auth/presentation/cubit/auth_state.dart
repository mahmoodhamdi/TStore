part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthPasswordVisibilityToggled extends AuthState {
  @override
  List<Object> get props => [];
}

class AuthSigningUpWithEmail extends AuthState {}

class AuthVerifyingEmail extends AuthState {}

class AuthVerifiedEmail extends AuthState {}

class AuthSendingVerifyingEmail extends AuthState {}

class AuthUnverifiedEmail extends AuthState {}

class AuthVerifyingEmailSent extends AuthState {}

class AuthEmailNotVerified extends AuthState {
  final String email;

  const AuthEmailNotVerified({required this.email});
}

class AuthSignedUpWithEmail extends AuthState {
  final AuthRegisterModel authRegisterModel;

  const AuthSignedUpWithEmail({required this.authRegisterModel});
}

class AuthSigningUpWithGoogle extends AuthState {}

class AuthSignedUpWithGoogle extends AuthState {}

class AuthLoggingInWithEmail extends AuthState {}

class AuthLoggedInWithEmail extends AuthState {}

class AuthSigningInWithGoogle extends AuthState {}

class AuthSignedInWithGoogle extends AuthState {}

class AuthSigningInWithFacebook extends AuthState {}

class AuthSignedInWithFacebook extends AuthState {}

class AuthForgettingPassword extends AuthState {}

class AuthPasswordReset extends AuthState {}

class AuthLoggingOut extends AuthState {}

class AuthLoggedOut extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});
  @override
  List<Object> get props => [message];
}

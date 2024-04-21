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

class AuthNotConnected extends AuthState {}

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

class AuthDeletingAccount extends AuthState {}

class AuthDeletedAccount extends AuthState {}

class AuthFetchingUserData extends AuthState {}

class AuthSavingUserData extends AuthState {}

class AuthSavedUserData extends AuthState {}

class AuthFetchedUserData extends AuthState {
  final UserModel userModel;
  const AuthFetchedUserData({required this.userModel});
}

class AuthImageUploading extends AuthState {}

class AuthImageUploaded extends AuthState {}

class AuthError extends AuthState {
  final String message;

  const AuthError({required this.message});
  @override
  List<Object> get props => [message];
}

part of 'auth_cubit.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthSigningUpWithEmail extends AuthState {}

class AuthSignedUpWithEmail extends AuthState {}

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

// login_status_cubit.dart
import 'package:equatable/equatable.dart';

enum AuthStatus { initial, checking, authenticated, unauthenticated }

class LoginStatusState extends Equatable {
  final AuthStatus status;
  final String? errorMessage;

  const LoginStatusState({
    this.status = AuthStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];

  LoginStatusState copyWith({
    AuthStatus? status,
    String? errorMessage,
  }) {
    return LoginStatusState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

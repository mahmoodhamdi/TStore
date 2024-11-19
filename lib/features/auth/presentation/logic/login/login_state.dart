import 'package:equatable/equatable.dart';
import 'package:t_store/core/enums/status.dart';

class LoginState extends Equatable {
  final LoginStatus status;
  final String message; // Optional: for success/failure messages

  const LoginState({
    this.status = LoginStatus.initial,
    this.message = '',
  });

  LoginState copyWith({
    LoginStatus? status,
    String? message,
  }) {
    return LoginState(
      status: status ?? this.status,
      message: message ?? this.message,
    );
  }

  @override
  List<Object> get props => [status, message];
}

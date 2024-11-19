// logout_cubit.dart
import 'package:equatable/equatable.dart';
import 'package:t_store/core/enums/status.dart';

class LogoutState extends Equatable {
  final LogoutStatus status;
  final String? errorMessage;

  const LogoutState({
    this.status = LogoutStatus.initial,
    this.errorMessage,
  });

  @override
  List<Object?> get props => [status, errorMessage];

  LogoutState copyWith({
    LogoutStatus? status,
    String? errorMessage,
  }) {
    return LogoutState(
      status: status ?? this.status,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}

import 'package:equatable/equatable.dart';
import 'package:t_store/core/enums/status.dart';
import 'package:t_store/features/auth/data/models/change_password_response.dart';

class SetNewPasswordState extends Equatable {
  final SetNewPasswordStatus status;
  final ChangePasswordResponseData?
      response; // Holds the entire response object
  final String? message;

  const SetNewPasswordState({
    this.status = SetNewPasswordStatus.initial,
    this.response,
    this.message,
  });

  SetNewPasswordState copyWith({
    SetNewPasswordStatus? status,
    ChangePasswordResponseData? response,
    String? message,
  }) {
    return SetNewPasswordState(
      status: status ?? this.status,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, response, message];
}

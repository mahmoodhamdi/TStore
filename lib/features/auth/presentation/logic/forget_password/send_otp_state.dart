import 'package:equatable/equatable.dart';
import 'package:t_store/core/enums/status.dart';
import 'package:t_store/features/auth/data/models/send_otp_response.dart';

class SendOtpState extends Equatable {
  final ForgetPasswordStatus status;
  final String email;
  final SendOtpResponseData? response; // Now holds the entire response object
  final String? message;

  const SendOtpState({
    this.status = ForgetPasswordStatus.initial,
    this.email = '',
    this.response,
    this.message,
  });

  SendOtpState copyWith({
    ForgetPasswordStatus? status,
    String? email,
    SendOtpResponseData? response,
    String? message,
  }) {
    return SendOtpState(
      status: status ?? this.status,
      email: email ?? this.email,
      response: response ?? this.response,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [status, email, response, message];
}

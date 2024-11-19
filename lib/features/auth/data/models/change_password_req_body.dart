import 'package:equatable/equatable.dart';

class ChangePasswordReqBody extends Equatable {
  final String otp;
  final String token;
  final String newPassword;
  final String confirmPassword;

  const ChangePasswordReqBody({
    required this.otp,
    required this.token,
    required this.newPassword,
    required this.confirmPassword,
  });

  @override
  List<Object> get props => [otp, token,newPassword, confirmPassword];

  // Factory constructor to create the object from a JSON map
  factory ChangePasswordReqBody.fromJson(Map<String, dynamic> json) {
    return ChangePasswordReqBody(
      otp: json['old_password'],
      token: json['token'],
      newPassword: json['new_password'],
      confirmPassword: json['c_password'],
    );
  }

  // Method to convert the object into a JSON map
  Map<String, dynamic> toJson() {
    return {
      'old_password': otp,
      'new_password': newPassword,
      'c_password': confirmPassword,
    };
  }
}

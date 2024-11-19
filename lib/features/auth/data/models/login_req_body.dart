import 'package:equatable/equatable.dart';

class LoginReqBody extends Equatable {
  final String phoneEmail;
  final String password;

  const LoginReqBody({
    required this.phoneEmail,
    required this.password,
  });

  @override
  List<Object?> get props => [phoneEmail, password];

  Map<String, dynamic> toJson() {
    return {
      'phone_email': phoneEmail,
      'password': password,
    };
  }
}

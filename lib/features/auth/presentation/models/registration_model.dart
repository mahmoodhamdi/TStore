import 'package:equatable/equatable.dart';

class RegistrationModel extends Equatable {
  final String name;
  final String email;
  final String password;
  final String cPassword;
  final String mobile;
  final String address;

  const RegistrationModel({
    required this.name,
    required this.email,
    required this.password,
    required this.cPassword,
    required this.mobile,
    required this.address,
  });

  @override
  List<Object?> get props =>
      [name, email, password, cPassword, mobile, address];
}

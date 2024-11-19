import 'package:equatable/equatable.dart';

class RegisterReqBody extends Equatable {
  final String name;
  final String email;
  final String password;
  final String confirmPassword; // Added confirm password
  final String address;
  final String mobile; // Changed from phone to mobile

  const RegisterReqBody({
    required this.name,
    required this.email,
    required this.password,
    required this.confirmPassword, // Added confirm password
    required this.address,
    required this.mobile, // Added mobile
  });

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'password': password,
        'c_password': confirmPassword, // Include confirm password
        'address': address,
        'mobile': mobile, // Include mobile
      };

  @override
  List<Object?> get props =>
      [name, email, password, confirmPassword, address, mobile]; // Updated props
}

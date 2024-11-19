import 'package:equatable/equatable.dart';

class UpdateProfileRequest extends Equatable {
  final String name;
  final String mobile;
  final String email;

  const UpdateProfileRequest({
    required this.name,
    required this.mobile,
    required this.email,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'mobile': mobile,
      'email': email,
    };
  }

  @override
  List<Object?> get props => [name, mobile, email];
}

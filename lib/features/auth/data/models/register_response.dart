import 'package:equatable/equatable.dart';

class RegisterResponse extends Equatable {
  final bool status;
  final String errorMessage;
  final String errorMessageEn;
  final RegisterUserData? data;

  const RegisterResponse({
    required this.status,
    required this.errorMessage,
    required this.errorMessageEn,
    this.data,
  });

  factory RegisterResponse.fromJson(Map<String, dynamic> json) {
    if (json['status'] == true) {
      // Status is true, parse the user data
      return RegisterResponse(
        status: json['status'],
        errorMessage: '', // No error message on success
        errorMessageEn: '', // No error message on success
        data: RegisterUserData.fromJson(json['data']),
      );
    } else {
      // Status is false, parse the error messages
      return RegisterResponse(
        status: json['status'],
        errorMessage: json['error_message'] ?? '',
        errorMessageEn: json['error_message_en'] ?? '',
        data: null, // No user data on error
      );
    }
  }

  @override
  List<Object?> get props => [status, errorMessage, errorMessageEn, data];
}

class RegisterUserData extends Equatable {
  final String mobile;
  final String name;
  final String email;
  final String address;
  final String? profilePhotoPath;
  final String token;

  const RegisterUserData({
    required this.mobile,
    required this.name,
    required this.email,
    required this.address,
    this.profilePhotoPath,
    required this.token,
  });

  factory RegisterUserData.fromJson(Map<String, dynamic> json) {
    return RegisterUserData(
      mobile: json['mobile'],
      name: json['name'],
      email: json['email'],
      address: json['address'],
      profilePhotoPath: json['profile_photo_path'],
      token: json['token'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'mobile': mobile,
      'name': name,
      'email': email,
      'address': address,
      'profile_photo_path': profilePhotoPath,
      'token': token,
    };
  }

  @override
  List<Object?> get props =>
      [mobile, name, email, address, profilePhotoPath, token];
}

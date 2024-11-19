import 'package:equatable/equatable.dart';

class LoginResponse extends Equatable {
  final bool status;
  final String message;
  final LoginUserData? data;

  const LoginResponse({
    required this.status,
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [status, message, data];

  factory LoginResponse.fromJson(Map<String, dynamic> json) {
    return LoginResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? LoginUserData.fromJson(json['data']) : null,
    );
  }
}


class LoginUserData extends Equatable {
  final int id;
  final String name;
  final String mobile;
  final String email;
  final int roleId;
  final String address;
  final String? profilePhotoPath;
  final String token;
  final String profilePhotoUrl;

  const LoginUserData({
    required this.id,
    required this.name,
    required this.mobile,
    required this.email,
    required this.roleId,
    required this.address,
    this.profilePhotoPath,
    required this.token,
    required this.profilePhotoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        mobile,
        email,
        roleId,
        address,
        profilePhotoPath,
        token,
        profilePhotoUrl,
      ];
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'mobile': mobile,
      'email': email,
      'role_id': roleId,
      'address': address,
      'profile_photo_path': profilePhotoPath,
      'token': token,
      'profile_photo_url': profilePhotoUrl,
    };
  }
  factory LoginUserData.fromJson(Map<String, dynamic> json) {
    return LoginUserData(
      id: json['id'],
      name: json['name'],
      mobile: json['mobile'],
      email: json['email'],
      roleId: json['role_id'],
      address: json['address'],
      profilePhotoPath: json['profile_photo_path'],
      token: json['token'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }
}

import 'package:equatable/equatable.dart';

class ChangePasswordResponse extends Equatable {
  final bool status;
  final String message;
  final ChangePasswordResponseData? data;

  const ChangePasswordResponse({
    required this.status,
    required this.message,
    this.data,
  });

  factory ChangePasswordResponse.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null ? ChangePasswordResponseData.fromJson(json['data']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'data': data?.toJson(),
    };
  }

  @override
  List<Object?> get props => [status, message, data];
}

class ChangePasswordResponseData extends Equatable {
  final int id;
  final String mobile;
  final String email;
  final String address;
  final String userLang;
  final String? profilePhotoUrl;

  const ChangePasswordResponseData({
    required this.id,
    required this.mobile,
    required this.email,
    required this.address,
    required this.userLang,
    this.profilePhotoUrl,
  });

  factory ChangePasswordResponseData.fromJson(Map<String, dynamic> json) {
    return ChangePasswordResponseData(
      id: json['id'],
      mobile: json['mobile'],
      email: json['email'],
      address: json['address'],
      userLang: json['user_lang'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'mobile': mobile,
      'email': email,
      'address': address,
      'user_lang': userLang,
      'profile_photo_url': profilePhotoUrl,
    };
  }

  @override
  List<Object?> get props =>
      [id, mobile, email, address, userLang, profilePhotoUrl];
}

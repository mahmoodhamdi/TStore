import 'package:equatable/equatable.dart';

class UpdateProfileResponseData extends Equatable {
  final int id;
  final String name;
  final String email;
  final String mobile;
  final String profilePhotoPath;

  const UpdateProfileResponseData({
    required this.id,
    required this.name,
    required this.email,
    required this.mobile,
    required this.profilePhotoPath,
  });

  factory UpdateProfileResponseData.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponseData(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      mobile: json['mobile'],
      profilePhotoPath: json['profile_photo_path'],
    );
  }

  @override
  List<Object?> get props => [id, name, email, mobile, profilePhotoPath];
}

class UpdateProfileResponse extends Equatable {
  final bool status;
  final String message;
  final UpdateProfileResponseData? data;
  final String? errorMessage;

  const UpdateProfileResponse({
    required this.status,
    required this.message,
    this.data,
    this.errorMessage,
  });

  factory UpdateProfileResponse.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponse(
      status: json['status'],
      message: json['message'],
      data: json['data'] != null
          ? UpdateProfileResponseData.fromJson(json['data'])
          : null,
      errorMessage: json['error_message'],
    );
  }

  @override
  List<Object?> get props => [status, message, data, errorMessage];
}

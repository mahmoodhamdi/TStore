import 'package:equatable/equatable.dart';

class SendOtpResponse extends Equatable {
  final bool status;
  final String message;
  final SendOtpResponseData? data;

  const SendOtpResponse({
    required this.status,
    required this.message,
    this.data,
  });

  @override
  List<Object?> get props => [status, message, data];

  factory SendOtpResponse.fromJson(Map<String, dynamic> json) {
    return SendOtpResponse(
      status: json['status'] ?? false,
      message: json['message'] ?? '',
      data: json['data'] != null
          ? SendOtpResponseData.fromJson(json['data'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}

class SendOtpResponseData extends Equatable {
  final int id;
  final int userTypeId;
  final int roleId;
  final dynamic memberPlan;
  final String name;
  final String? nameEn;
  final String? lastName;
  final String? userName;
  final String mobile;
  final String email;
  final String? emailVerifiedAt;
  final dynamic currentTeamId;
  final String address;
  final String? profilePhotoPath;
  final dynamic columnsNeedApprove;
  final dynamic activationCode;
  final String isConnect;
  final dynamic lastConnectedAt;
  final String onesignalId;
  final int userBalance;
  final String userLang;
  final int changeUserType;
  final String isActive;
  final dynamic deletedAt;
  final String createdAt;
  final String updatedAt;
  final int newPassword;
  final String token;
  final String profilePhotoUrl;

  const SendOtpResponseData({
    required this.id,
    required this.userTypeId,
    required this.roleId,
    this.memberPlan,
    required this.name,
    this.nameEn,
    this.lastName,
    this.userName,
    required this.mobile,
    required this.email,
    this.emailVerifiedAt,
    this.currentTeamId,
    required this.address,
    this.profilePhotoPath,
    this.columnsNeedApprove,
    this.activationCode,
    required this.isConnect,
    this.lastConnectedAt,
    required this.onesignalId,
    required this.userBalance,
    required this.userLang,
    required this.changeUserType,
    required this.isActive,
    this.deletedAt,
    required this.createdAt,
    required this.updatedAt,
    required this.newPassword,
    required this.token,
    required this.profilePhotoUrl,
  });

  @override
  List<Object?> get props => [
        id,
        userTypeId,
        roleId,
        memberPlan,
        name,
        nameEn,
        lastName,
        userName,
        mobile,
        email,
        emailVerifiedAt,
        currentTeamId,
        address,
        profilePhotoPath,
        columnsNeedApprove,
        activationCode,
        isConnect,
        lastConnectedAt,
        onesignalId,
        userBalance,
        userLang,
        changeUserType,
        isActive,
        deletedAt,
        createdAt,
        updatedAt,
        newPassword,
        token,
        profilePhotoUrl,
      ];

  factory SendOtpResponseData.fromJson(Map<String, dynamic> json) {
    return SendOtpResponseData(
      id: json['id'],
      userTypeId: json['user_type_id'],
      roleId: json['role_id'],
      memberPlan: json['member_plan'],
      name: json['name'],
      nameEn: json['name_en'],
      lastName: json['last_name'],
      userName: json['user_name'],
      mobile: json['mobile'],
      email: json['email'],
      emailVerifiedAt: json['email_verified_at'],
      currentTeamId: json['current_team_id'],
      address: json['address'],
      profilePhotoPath: json['profile_photo_path'],
      columnsNeedApprove: json['columns_need_approve'],
      activationCode: json['activitation_code'],
      isConnect: json['is_connect'],
      lastConnectedAt: json['last_connected_at'],
      onesignalId: json['onesignal_id'] ?? "",
      userBalance: json['user_balance'],
      userLang: json['user_lang'],
      changeUserType: json['change_user_type'],
      isActive: json['is_active'],
      deletedAt: json['deleted_at'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      newPassword: json['new_password'],
      token: json['token'],
      profilePhotoUrl: json['profile_photo_url'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['id'] = id;
    data['user_type_id'] = userTypeId;
    data['role_id'] = roleId;
    data['member_plan'] = memberPlan;
    data['name'] = name;
    data['name_en'] = nameEn;
    data['last_name'] = lastName;
    data['user_name'] = userName;
    data['mobile'] = mobile;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['current_team_id'] = currentTeamId;
    data['address'] = address;
    data['profile_photo_path'] = profilePhotoPath;
    data['columns_need_approve'] = columnsNeedApprove;
    data['activitation_code'] = activationCode;
    data['is_connect'] = isConnect;
    data['last_connected_at'] = lastConnectedAt;
    data['onesignal_id'] = onesignalId;
    data['user_balance'] = userBalance;
    data['user_lang'] = userLang;
    data['change_user_type'] = changeUserType;
    data['is_active'] = isActive;
    data['deleted_at'] = deletedAt;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['new_password'] = newPassword;
    data['token'] = token;
    data['profile_photo_url'] = profilePhotoUrl;
    return data;
  }
}

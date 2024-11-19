import 'package:dartz/dartz.dart';
import 'package:t_store/features/auth/data/models/change_password_req_body.dart';
import 'package:t_store/features/auth/data/models/change_password_response.dart';
import 'package:t_store/features/auth/data/models/login_req_body.dart';
import 'package:t_store/features/auth/data/models/login_response.dart';
import 'package:t_store/features/auth/data/models/register_req_body.dart';
import 'package:t_store/features/auth/data/models/register_response.dart';
import 'package:t_store/features/auth/data/models/send_otp_req_body.dart';
import 'package:t_store/features/auth/data/models/send_otp_response.dart';

abstract class AuthRepo {
  Future<Either<String, RegisterUserData>> register(
      {required RegisterReqBody registerReqBody});
  Future<Either<String, LoginUserData>> login(
      {required LoginReqBody loginReqBody});
  Future<void> logout();
  Future<LoginUserData?> getCachedUser();
  Future<bool> isLoggedIn();
  Future<Either<String, SendOtpResponseData>> sendOtp(
      {required SendOtpReqBody forgetPasswordReqBody});
  Future<Either<String, ChangePasswordResponseData>> setNewPassword(
      {required ChangePasswordReqBody changePasswordReqBody});
}

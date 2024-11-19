import 'package:dartz/dartz.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/utils/helpers/send_mail_helper.dart';
 import 'package:t_store/features/auth/data/data_sources/auth_local_data_source.dart';
import 'package:t_store/features/auth/data/data_sources/auth_remote_data_source.dart';
import 'package:t_store/features/auth/data/models/change_password_req_body.dart';
import 'package:t_store/features/auth/data/models/change_password_response.dart';
import 'package:t_store/features/auth/data/models/login_req_body.dart';
import 'package:t_store/features/auth/data/models/login_response.dart';
import 'package:t_store/features/auth/data/models/register_req_body.dart';
import 'package:t_store/features/auth/data/models/register_response.dart';
import 'package:t_store/features/auth/data/models/send_otp_req_body.dart';
import 'package:t_store/features/auth/data/models/send_otp_response.dart';
import 'package:t_store/features/auth/domain/repository/auth_repo.dart';

class AuthRepoImpl implements AuthRepo {
  @override
  Future<Either<String, RegisterUserData>> register(
      {required RegisterReqBody registerReqBody}) async {
    final result = await sl<AuthRemoteDataSource>()
        .register(registerReqBody: registerReqBody);
    return result.fold(
      (error) => Left(error),
      (userData) async {
        return Right(userData);
      },
    );
  }

  @override
  Future<Either<String, LoginUserData>> login(
      {required LoginReqBody loginReqBody}) async {
    final result =
        await sl<AuthRemoteDataSource>().login(loginReqBody: loginReqBody);
    return result.fold(
      (error) => Left(error),
      (userData) async {
        await sl<AuthLocalDataSource>().cacheUserData(userData);
        await sl<AuthLocalDataSource>().saveToken(userData.token);
        return Right(userData);
      },
    );
  }

  // You might want to add these additional methods to your AuthRepo interface
  @override
  Future<void> logout() async {
    await sl<AuthLocalDataSource>().clearUserData();
  }

  @override
  Future<LoginUserData?> getCachedUser() async {
    return await sl<AuthLocalDataSource>().getCachedUserData();
  }

  @override
  Future<bool> isLoggedIn() async {
    return await sl<AuthLocalDataSource>().isLoggedIn();
  }

  @override
  Future<Either<String, SendOtpResponseData>> sendOtp(
      {required SendOtpReqBody forgetPasswordReqBody}) async {
    final result = await sl<AuthRemoteDataSource>()
        .sendOtp(forgetPasswordReqBody: forgetPasswordReqBody);
    return result.fold(
      (error) => Left(error),
      (success) async {
        String username = 'hmdy7486@gmail.com';
        String password = dotenv.env['APP_PASSWORD'] ?? '';

        final sendMailHelper =
            SendMailHelper(username: username, password: password);
        await sendMailHelper.sendOtpEmail(
            success.email, success.newPassword.toString());

        return Right(success);
      },
    );
  }

  @override
  Future<Either<String, ChangePasswordResponseData>> setNewPassword(
      {required ChangePasswordReqBody changePasswordReqBody}) async {
    final result = await sl<AuthRemoteDataSource>()
        .setNewPassword(changePasswordReqBody: changePasswordReqBody);
    return result.fold(
      (error) => Left(error),
      (success) async {
        return Right(success);
      },
    );
  }
}

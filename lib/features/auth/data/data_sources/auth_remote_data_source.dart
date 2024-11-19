import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/network/dio_client.dart';
import 'package:t_store/core/utils/constants/api_constants.dart';
import 'package:t_store/core/utils/helpers/dio_exception_helper.dart';
import 'package:t_store/core/utils/helpers/platform_exception_helper.dart';
import 'package:t_store/features/auth/data/models/change_password_req_body.dart';
import 'package:t_store/features/auth/data/models/change_password_response.dart';
import 'package:t_store/features/auth/data/models/login_req_body.dart';
import 'package:t_store/features/auth/data/models/login_response.dart';
import 'package:t_store/features/auth/data/models/register_req_body.dart';
import 'package:t_store/features/auth/data/models/register_response.dart';
import 'package:t_store/features/auth/data/models/send_otp_req_body.dart';
import 'package:t_store/features/auth/data/models/send_otp_response.dart';

abstract class AuthRemoteDataSource {
  Future<Either<String, RegisterUserData>> register(
      {required RegisterReqBody registerReqBody});
  Future<Either<String, LoginUserData>> login(
      {required LoginReqBody loginReqBody});
  Future<Either<String, SendOtpResponseData>> sendOtp(
      {required SendOtpReqBody forgetPasswordReqBody});
  Future<Either<String, ChangePasswordResponseData>> setNewPassword(
      {required ChangePasswordReqBody changePasswordReqBody});
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  @override
  Future<Either<String, RegisterUserData>> register(
      {required RegisterReqBody registerReqBody}) async {
    try {
      var response = await sl<DioClient>().post(
        ApiConstants.registerUrl,
        data: registerReqBody.toJson(),
      );

      RegisterResponse registerResponseModel =
          RegisterResponse.fromJson(response.data);

      if (registerResponseModel.status) {
        return Right(registerResponseModel.data!);
      } else {
        return Left(registerResponseModel.errorMessage);
      }
    } on DioException catch (e) {
      // Handle the DioException using DioExceptionHelper
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      // Handle the PlatformException using PlatformExceptionHelper
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left(
          'حدث خطأ غير متوقع: $e'); // Arabic for "An unexpected error occurred"
    }
  }

  @override
  Future<Either<String, LoginUserData>> login(
      {required LoginReqBody loginReqBody}) async {
    try {
      var response = await sl<DioClient>().post(
        ApiConstants.loginUrl,
        data: loginReqBody.toJson(),
      );

      LoginResponse loginResponse = LoginResponse.fromJson(response.data);

      if (loginResponse.status) {
        return Right(loginResponse.data!);
      } else {
        return Left(loginResponse.message);
      }
    } on DioException catch (e) {
      // Handle the DioException using DioExceptionHelper
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      // Handle the PlatformException using PlatformExceptionHelper
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left(
          'حدث خطأ غير متوقع: $e'); // Arabic for "An unexpected error occurred"
    }
  }

  @override
  Future<Either<String, SendOtpResponseData>> sendOtp(
      {required SendOtpReqBody forgetPasswordReqBody}) async {
    try {
      var response = await sl<DioClient>().post(ApiConstants.forgotPasswordUrl,
          data: forgetPasswordReqBody.toJson());
      SendOtpResponse forgetPassResponse =
          SendOtpResponse.fromJson(response.data);
      if (forgetPassResponse.status) {
        return Right(forgetPassResponse.data!);
      } else {
        return Left(forgetPassResponse.message);
      }
    } on DioException catch (e) {
      // Handle the DioException using DioExceptionHelper
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      // Handle the PlatformException using PlatformExceptionHelper
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left(
          'حدث خطأ غير متوقع: $e'); // Arabic for "An unexpected error occurred"
    }
  }

  @override
  Future<Either<String, ChangePasswordResponseData>> setNewPassword(
      {required ChangePasswordReqBody changePasswordReqBody}) async {
    try {
      String token = changePasswordReqBody.token;
      var response = await sl<DioClient>().post(
        ApiConstants.resetPasswordUrl,
        data: changePasswordReqBody.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token', // Add the token here
            'Content-Type':
                'application/json', // Optionally set the content type
          },
        ),
      );
      ChangePasswordResponse changePasswordResponse =
          ChangePasswordResponse.fromJson(response.data);
      if (changePasswordResponse.status) {
        return Right(changePasswordResponse.data!);
      } else {
        return Left(changePasswordResponse.message);
      }
    } on DioException catch (e) {
      // Handle the DioException using DioExceptionHelper
      return Left(DioExceptionHelper.handleDioError(e));
    } on PlatformException catch (e) {
      // Handle the PlatformException using PlatformExceptionHelper
      return Left(PlatformExceptionHelper.handlePlatformError(e));
    } catch (e) {
      return Left(
          'حدث خطأ غير متوقع: $e'); // Arabic for "An unexpected error occurred"
    }
  }
}

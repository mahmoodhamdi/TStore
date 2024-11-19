import 'package:dartz/dartz.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/usecase/usecase.dart';
import 'package:t_store/features/auth/data/models/send_otp_req_body.dart';
import 'package:t_store/features/auth/data/models/send_otp_response.dart';
import 'package:t_store/features/auth/domain/repository/auth_repo.dart';

class SendOtpUsecase extends UseCase<Either, SendOtpParms> {
  @override
  Future<Either<String, SendOtpResponseData>> call(
      {SendOtpParms? param}) async {
    if (param == null) throw ArgumentError('RegisterParams cannot be null');

    return await sl<AuthRepo>()
        .sendOtp(forgetPasswordReqBody: param.forgetPasswordReqBody);
  }
}

class SendOtpParms {
  final SendOtpReqBody forgetPasswordReqBody;

  SendOtpParms({required this.forgetPasswordReqBody});
}

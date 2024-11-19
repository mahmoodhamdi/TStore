import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/enums/status.dart';
import 'package:t_store/features/auth/data/models/send_otp_req_body.dart';
import 'package:t_store/features/auth/domain/usecases/send_otp_usecase.dart';
import 'package:t_store/features/auth/presentation/logic/forget_password/send_otp_state.dart';

class SendOtpCubit extends Cubit<SendOtpState> {
  SendOtpCubit() : super(const SendOtpState());

  Future<void> sendOtp(SendOtpReqBody forgetPasswordReqBody) async {
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final Either result = await sl<SendOtpUsecase>().call(
        param: SendOtpParms(forgetPasswordReqBody: forgetPasswordReqBody));

    result.fold(
      (failure) => emit(state.copyWith(
          status: ForgetPasswordStatus.failure, message: failure)),
      (success) async {
        emit(state.copyWith(
            status: ForgetPasswordStatus.success, response: success));
      },
    );
  }

  void reset() {
    emit(const SendOtpState());
  }
}

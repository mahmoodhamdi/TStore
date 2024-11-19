import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/enums/status.dart';
import 'package:t_store/features/auth/data/models/change_password_req_body.dart';
import 'package:t_store/features/auth/data/models/change_password_response.dart';
import 'package:t_store/features/auth/domain/usecases/set_new_password_usecase.dart';
import 'package:t_store/features/auth/presentation/logic/set_new_password/set_new_password_state.dart';

class SetNewPasswordCubit extends Cubit<SetNewPasswordState> {
  SetNewPasswordCubit() : super(const SetNewPasswordState());

  Future<void> setNewPassword(
      ChangePasswordReqBody changePasswordReqBody) async {
    emit(state.copyWith(status: SetNewPasswordStatus.loading));

    final Either<String, ChangePasswordResponseData> result =
        await sl<SetNewPasswordUsecase>().call(
      param: SetNewPasswordParms(changePasswordReqBody: changePasswordReqBody),
    );

    result.fold(
      (failure) => emit(state.copyWith(
          status: SetNewPasswordStatus.failure, message: failure)),
      (success) async {
        emit(state.copyWith(
          status: SetNewPasswordStatus.success,
          response: success,
        ));
      },
    );
  }

  void reset() {
    emit(const SetNewPasswordState());
  }
}

import 'package:dartz/dartz.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/usecase/usecase.dart';
import 'package:t_store/features/auth/data/models/change_password_req_body.dart';
import 'package:t_store/features/auth/data/models/change_password_response.dart';
import 'package:t_store/features/auth/domain/repository/auth_repo.dart';

class SetNewPasswordUsecase extends UseCase<Either, SetNewPasswordParms> {
  @override
  Future<Either<String, ChangePasswordResponseData>> call(
      {SetNewPasswordParms? param}) async {
    if (param == null) {
      throw ArgumentError('SetNewPasswordParms cannot be null');
    }

    return await sl<AuthRepo>()
        .setNewPassword(changePasswordReqBody: param.changePasswordReqBody);
  }
}

class SetNewPasswordParms {
  final ChangePasswordReqBody changePasswordReqBody;

  SetNewPasswordParms({required this.changePasswordReqBody});
}

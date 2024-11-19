import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/usecase/usecase.dart';
import 'package:t_store/features/auth/domain/repository/auth_repo.dart';

class LogoutUsecase extends UseCase<void, NoParams> {
  @override
  Future<void> call({NoParams? param}) async {
    await sl<AuthRepo>().logout();
  }
}

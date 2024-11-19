import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/enums/status.dart';
import 'package:t_store/features/auth/domain/usecases/logout_usecase.dart';
import 'package:t_store/features/auth/presentation/logic/logout/logout_state.dart';

class LogoutCubit extends Cubit<LogoutState> {
  final LogoutUsecase logoutUsecase;

  LogoutCubit({
    LogoutUsecase? logoutUsecase,
  })  : logoutUsecase = logoutUsecase ?? sl<LogoutUsecase>(),
        super(const LogoutState());

  Future<void> logout() async {
    emit(state.copyWith(status: LogoutStatus.loading));

    try {
      await logoutUsecase.call();
      emit(state.copyWith(status: LogoutStatus.success));
    } catch (e) {
      emit(state.copyWith(
        status: LogoutStatus.failure,
        errorMessage: 'حدث خطأ أثناء تسجيل الخروج: $e', // Error during logout
      ));
    }
  }
}

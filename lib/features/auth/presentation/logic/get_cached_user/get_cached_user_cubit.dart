// get_cached_user_cubit.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/enums/status.dart';
import 'package:t_store/features/auth/domain/usecases/get_cached_user_usecase.dart';
import 'package:t_store/features/auth/presentation/logic/get_cached_user/get_cached_user_state.dart';

class CachedUserCubit extends Cubit<CachedUserState> {
  CachedUserCubit() : super(const CachedUserState());

  Future<void> getCachedUser() async {
    emit(state.copyWith(status: CachedUserStatus.loading));

    try {
      final userData = await sl<GetCachedUserUsecase>().call();
      if (userData != null) {
        emit(state.copyWith(
          status: CachedUserStatus.success,
          userData: userData,
        ));
      } else {
        emit(state.copyWith(
          status: CachedUserStatus.failure,
          errorMessage:
              'لا يوجد بيانات مستخدم محفوظة', // No cached user data found
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        status: CachedUserStatus.failure,
        errorMessage:
            'حدث خطأ أثناء جلب بيانات المستخدم: $e', // Error fetching user data
      ));
    }
  }
}

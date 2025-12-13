import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/get_profile_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/update_profile_usecase.dart';
import 'package:t_store/features/personalization/presentation/cubit/profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final GetProfileUsecase getProfileUsecase;
  final UpdateProfileUsecase updateProfileUsecase;

  ProfileCubit({
    required this.getProfileUsecase,
    required this.updateProfileUsecase,
  }) : super(ProfileInitial());

  Future<void> getProfile() async {
    emit(ProfileLoading());

    final result = await getProfileUsecase(const NoParams());

    result.fold(
      (error) => emit(ProfileError(error)),
      (user) => emit(ProfileLoaded(user)),
    );
  }

  Future<void> updateProfile({
    String? fullName,
    String? phone,
  }) async {
    emit(ProfileUpdating());

    final result = await updateProfileUsecase(UpdateProfileParams(
      fullName: fullName,
      phone: phone,
    ));

    result.fold(
      (error) => emit(ProfileError(error)),
      (user) {
        emit(ProfileUpdated(user));
        emit(ProfileLoaded(user));
      },
    );
  }
}

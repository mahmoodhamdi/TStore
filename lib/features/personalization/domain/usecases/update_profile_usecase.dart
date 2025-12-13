import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';
import 'package:t_store/features/personalization/domain/repositories/profile_repository.dart';

class UpdateProfileUsecase
    implements UseCase<UserEntity, UpdateProfileParams> {
  final ProfileRepository repository;

  UpdateProfileUsecase(this.repository);

  @override
  Future<Either<String, UserEntity>> call(UpdateProfileParams params) async {
    return await repository.updateProfile(
      fullName: params.fullName,
      phone: params.phone,
    );
  }
}

class UpdateProfileParams {
  final String? fullName;
  final String? phone;

  UpdateProfileParams({
    this.fullName,
    this.phone,
  });
}

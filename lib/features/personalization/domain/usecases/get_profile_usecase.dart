import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';
import 'package:t_store/features/personalization/domain/repositories/profile_repository.dart';

class GetProfileUsecase implements UseCase<UserEntity, NoParams> {
  final ProfileRepository repository;

  GetProfileUsecase(this.repository);

  @override
  Future<Either<String, UserEntity>> call(NoParams params) async {
    return await repository.getProfile();
  }
}

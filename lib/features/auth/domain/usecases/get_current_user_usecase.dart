import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';
import 'package:t_store/features/auth/domain/repositories/auth_repository.dart';

class GetCurrentUserUsecase implements UseCase<UserEntity?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUsecase(this.repository);

  @override
  Future<Either<String, UserEntity?>> call(NoParams params) async {
    return await repository.getCurrentUser();
  }
}

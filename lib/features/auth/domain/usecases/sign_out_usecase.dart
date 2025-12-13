import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/auth/domain/repositories/auth_repository.dart';

class SignOutUsecase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOutUsecase(this.repository);

  @override
  Future<Either<String, void>> call(NoParams params) async {
    return await repository.signOut();
  }
}

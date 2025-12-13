import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/auth/domain/repositories/auth_repository.dart';

class ResetPasswordUsecase implements UseCase<void, String> {
  final AuthRepository repository;

  ResetPasswordUsecase(this.repository);

  @override
  Future<Either<String, void>> call(String email) async {
    return await repository.resetPassword(email);
  }
}

import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/personalization/domain/repositories/address_repository.dart';

class DeleteAddressUsecase implements UseCase<void, String> {
  final AddressRepository repository;

  DeleteAddressUsecase(this.repository);

  @override
  Future<Either<String, void>> call(String id) async {
    return await repository.deleteAddress(id);
  }
}

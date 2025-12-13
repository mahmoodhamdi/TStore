import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/personalization/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/domain/repositories/address_repository.dart';

class GetAddressesUsecase implements UseCase<List<AddressEntity>, NoParams> {
  final AddressRepository repository;

  GetAddressesUsecase(this.repository);

  @override
  Future<Either<String, List<AddressEntity>>> call(NoParams params) async {
    return await repository.getAddresses();
  }
}

import 'package:dartz/dartz.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/personalization/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/domain/repositories/address_repository.dart';

class UpdateAddressUsecase
    implements UseCase<AddressEntity, UpdateAddressParams> {
  final AddressRepository repository;

  UpdateAddressUsecase(this.repository);

  @override
  Future<Either<String, AddressEntity>> call(UpdateAddressParams params) async {
    return await repository.updateAddress(
      id: params.id,
      fullName: params.fullName,
      phone: params.phone,
      addressLine1: params.addressLine1,
      addressLine2: params.addressLine2,
      city: params.city,
      state: params.state,
      postalCode: params.postalCode,
      country: params.country,
      isDefault: params.isDefault,
    );
  }
}

class UpdateAddressParams {
  final String id;
  final String fullName;
  final String phone;
  final String addressLine1;
  final String? addressLine2;
  final String city;
  final String? state;
  final String? postalCode;
  final String country;
  final bool isDefault;

  UpdateAddressParams({
    required this.id,
    required this.fullName,
    required this.phone,
    required this.addressLine1,
    this.addressLine2,
    required this.city,
    this.state,
    this.postalCode,
    required this.country,
    this.isDefault = false,
  });
}

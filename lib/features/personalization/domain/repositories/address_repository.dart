import 'package:dartz/dartz.dart';
import 'package:t_store/features/personalization/domain/entities/address_entity.dart';

abstract class AddressRepository {
  Future<Either<String, List<AddressEntity>>> getAddresses();

  Future<Either<String, AddressEntity>> getAddressById(String id);

  Future<Either<String, AddressEntity>> addAddress({
    required String fullName,
    required String phone,
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? state,
    String? postalCode,
    required String country,
    bool isDefault = false,
  });

  Future<Either<String, AddressEntity>> updateAddress({
    required String id,
    required String fullName,
    required String phone,
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? state,
    String? postalCode,
    required String country,
    bool isDefault = false,
  });

  Future<Either<String, void>> deleteAddress(String id);

  Future<Either<String, void>> setDefaultAddress(String id);
}

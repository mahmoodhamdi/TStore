import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/get_addresses_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/add_address_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/update_address_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/delete_address_usecase.dart';
import 'package:t_store/features/personalization/presentation/cubit/addresses_state.dart';

class AddressesCubit extends Cubit<AddressesState> {
  final GetAddressesUsecase getAddressesUsecase;
  final AddAddressUsecase addAddressUsecase;
  final UpdateAddressUsecase updateAddressUsecase;
  final DeleteAddressUsecase deleteAddressUsecase;

  AddressesCubit({
    required this.getAddressesUsecase,
    required this.addAddressUsecase,
    required this.updateAddressUsecase,
    required this.deleteAddressUsecase,
  }) : super(AddressesInitial());

  Future<void> getAddresses() async {
    emit(AddressesLoading());

    final result = await getAddressesUsecase(const NoParams());

    result.fold(
      (error) => emit(AddressesError(error)),
      (addresses) => emit(AddressesLoaded(addresses)),
    );
  }

  Future<void> addAddress({
    required String fullName,
    required String phone,
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? state,
    String? postalCode,
    required String country,
    bool isDefault = false,
  }) async {
    emit(AddressAdding());

    final result = await addAddressUsecase(AddAddressParams(
      fullName: fullName,
      phone: phone,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country,
      isDefault: isDefault,
    ));

    result.fold(
      (error) => emit(AddressesError(error)),
      (address) {
        emit(AddressAdded(address));
        getAddresses();
      },
    );
  }

  Future<void> updateAddress({
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
  }) async {
    emit(AddressUpdating());

    final result = await updateAddressUsecase(UpdateAddressParams(
      id: id,
      fullName: fullName,
      phone: phone,
      addressLine1: addressLine1,
      addressLine2: addressLine2,
      city: city,
      state: state,
      postalCode: postalCode,
      country: country,
      isDefault: isDefault,
    ));

    result.fold(
      (error) => emit(AddressesError(error)),
      (address) {
        emit(AddressUpdated(address));
        getAddresses();
      },
    );
  }

  Future<void> deleteAddress(String id) async {
    final result = await deleteAddressUsecase(id);

    result.fold(
      (error) => emit(AddressesError(error)),
      (_) {
        emit(AddressDeleted(id));
        getAddresses();
      },
    );
  }
}

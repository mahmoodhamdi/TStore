import 'package:equatable/equatable.dart';
import 'package:t_store/features/personalization/domain/entities/address_entity.dart';

abstract class AddressesState extends Equatable {
  const AddressesState();

  @override
  List<Object?> get props => [];
}

class AddressesInitial extends AddressesState {}

class AddressesLoading extends AddressesState {}

class AddressesLoaded extends AddressesState {
  final List<AddressEntity> addresses;

  const AddressesLoaded(this.addresses);

  AddressEntity? get defaultAddress =>
      addresses.where((a) => a.isDefault).firstOrNull;

  @override
  List<Object?> get props => [addresses];
}

class AddressesError extends AddressesState {
  final String message;

  const AddressesError(this.message);

  @override
  List<Object?> get props => [message];
}

class AddressAdding extends AddressesState {}

class AddressAdded extends AddressesState {
  final AddressEntity address;

  const AddressAdded(this.address);

  @override
  List<Object?> get props => [address];
}

class AddressUpdating extends AddressesState {}

class AddressUpdated extends AddressesState {
  final AddressEntity address;

  const AddressUpdated(this.address);

  @override
  List<Object?> get props => [address];
}

class AddressDeleted extends AddressesState {
  final String addressId;

  const AddressDeleted(this.addressId);

  @override
  List<Object?> get props => [addressId];
}

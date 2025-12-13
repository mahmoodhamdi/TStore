import 'package:equatable/equatable.dart';
import 'package:t_store/features/shop/domain/entities/brand_entity.dart';

abstract class BrandsState extends Equatable {
  const BrandsState();

  @override
  List<Object?> get props => [];
}

class BrandsInitial extends BrandsState {}

class BrandsLoading extends BrandsState {}

class BrandsLoaded extends BrandsState {
  final List<BrandEntity> brands;

  const BrandsLoaded(this.brands);

  @override
  List<Object?> get props => [brands];
}

class BrandsError extends BrandsState {
  final String message;

  const BrandsError(this.message);

  @override
  List<Object?> get props => [message];
}

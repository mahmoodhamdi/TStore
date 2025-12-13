import 'package:equatable/equatable.dart';
import 'package:t_store/features/shop/domain/entities/banner_entity.dart';

abstract class BannersState extends Equatable {
  const BannersState();

  @override
  List<Object?> get props => [];
}

class BannersInitial extends BannersState {}

class BannersLoading extends BannersState {}

class BannersLoaded extends BannersState {
  final List<BannerEntity> banners;

  const BannersLoaded(this.banners);

  @override
  List<Object?> get props => [banners];
}

class BannersError extends BannersState {
  final String message;

  const BannersError(this.message);

  @override
  List<Object?> get props => [message];
}

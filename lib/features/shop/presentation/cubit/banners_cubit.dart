import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_banners_usecase.dart';
import 'package:t_store/features/shop/presentation/cubit/banners_state.dart';

class BannersCubit extends Cubit<BannersState> {
  final GetBannersUsecase getBannersUsecase;

  BannersCubit({required this.getBannersUsecase}) : super(BannersInitial());

  Future<void> getBanners() async {
    emit(BannersLoading());

    final result = await getBannersUsecase(const NoParams());

    result.fold(
      (error) => emit(BannersError(error)),
      (banners) => emit(BannersLoaded(banners)),
    );
  }
}

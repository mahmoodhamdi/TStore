import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/usecases/usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_categories_usecase.dart';
import 'package:t_store/features/shop/presentation/cubit/categories_state.dart';

class CategoriesCubit extends Cubit<CategoriesState> {
  final GetCategoriesUsecase getCategoriesUsecase;

  CategoriesCubit({required this.getCategoriesUsecase})
      : super(CategoriesInitial());

  Future<void> getCategories() async {
    emit(CategoriesLoading());

    final result = await getCategoriesUsecase(const NoParams());

    result.fold(
      (error) => emit(CategoriesError(error)),
      (categories) => emit(CategoriesLoaded(categories)),
    );
  }
}

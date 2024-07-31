import 'package:t_store/core/common/view_models/brand_showcase_view_model.dart';

class CategoryTabModel {
 final BrandShowcaseModel brandShowcaseModel;

  final List<String> products;
  final String categoryTitle;

  CategoryTabModel(
      {required this.brandShowcaseModel,
      required this.products,
      required this.categoryTitle});

   }

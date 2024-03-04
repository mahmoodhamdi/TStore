import 'package:t_store/core/common/models/brand_showcase_model.dart';

class CategoryTabModel {
 final BrandShowcaseModel brandShowcaseModel;

  final List<String> products;
  final String categoryTitle;

  CategoryTabModel(
      {required this.brandShowcaseModel,
      required this.products,
      required this.categoryTitle});

   }

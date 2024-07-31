import 'package:t_store/core/common/view_models/brand_card_view_model.dart';

class BrandShowcaseModel {
  final BrandCardModel brandCardModel;
  final List<String> topThreeProductsOfBrand;

  BrandShowcaseModel({required this.brandCardModel, required this.topThreeProductsOfBrand});
}

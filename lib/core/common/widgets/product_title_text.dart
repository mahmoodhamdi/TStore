import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/product_title_text_view_model.dart';

class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key,
    required this.productTitleTextModel,
  });
//ProductTitleText >> product_title_text.dart
  final ProductTitleTextModel productTitleTextModel;
  @override
  Widget build(BuildContext context) {
    return Text(productTitleTextModel.title,
        maxLines: productTitleTextModel.maxLines,
        textAlign: productTitleTextModel.textAlign,
        overflow: TextOverflow.ellipsis,
        style: productTitleTextModel.smallSize
            ? Theme.of(context).textTheme.labelLarge
            : Theme.of(context).textTheme.titleSmall);
  }
}

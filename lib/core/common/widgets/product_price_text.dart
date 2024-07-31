import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/product_price_text_view_model.dart';

class ProductPriceText extends StatelessWidget {
  const ProductPriceText({
    super.key,
    required this.productPriceTextModel,
  });
  final ProductPriceTextModel productPriceTextModel;
  @override
  Widget build(BuildContext context) {
    return Text(
        productPriceTextModel.currencySymbol + productPriceTextModel.price,
        maxLines: productPriceTextModel.maxLines,
        overflow: TextOverflow.ellipsis,
        style: productPriceTextModel.smallSize
            ? Theme.of(context).textTheme.titleLarge!.apply(
                  decoration: productPriceTextModel.lineThrough
                      ? TextDecoration.lineThrough
                      : null,
                )
            : Theme.of(context).textTheme.headlineMedium!.apply(
                  decoration: productPriceTextModel.lineThrough
                      ? TextDecoration.lineThrough
                      : null,
                ));
  }
}




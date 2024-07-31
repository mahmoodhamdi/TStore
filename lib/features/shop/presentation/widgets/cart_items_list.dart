import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/product_price_text_view_model.dart';
import 'package:t_store/core/common/widgets/product_price_text.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/shop/presentation/widgets/cart_item.dart';
import 'package:t_store/features/shop/presentation/widgets/product_quantity_with_add_and_remove_buttons.dart';

class CartItemsList extends StatelessWidget {
  const CartItemsList({
    super.key,
    this.showAddRemoveButtons = true,
  });
  final bool showAddRemoveButtons;
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) {
          return Column(
            children: [
              const CartItem(),
              if (showAddRemoveButtons)
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),
              if (showAddRemoveButtons)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Row(
                      children: [
                        SizedBox(
                          width: 70,
                        ),
                        ProductQuantityWithAddAndRemoveButtons(),
                      ],
                    ),
                    ProductPriceText(
                        productPriceTextModel: ProductPriceTextModel(
                            price: "175", smallSize: true)),
                  ],
                )
            ],
          );
        },
        separatorBuilder: (context, index) => const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
        itemCount: 5);
  }
}

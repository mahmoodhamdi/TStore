import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/models/product_price_text_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/common/widgets/product_price_text.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/shop/presentation/widgets/cart_item.dart';
import 'package:t_store/features/shop/presentation/widgets/product_quantity_with_add_and_remove_buttons.dart';

class CartView extends StatelessWidget {
  const CartView({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {},
          child: const Text("Checkout \$175"),
        ),
      ),
      appBar: CustomAppBar(
        appBarModel: AppBarModel(
          title: Text("Cart", style: Theme.of(context).textTheme.headlineSmall),
          hasArrowBack: true,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ListView.separated(
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const CartItem(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
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
            itemCount: 10),
      ),
    );
  }
}

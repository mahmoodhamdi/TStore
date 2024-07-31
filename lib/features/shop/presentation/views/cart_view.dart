import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/app_bar_view_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/views/checkout_view.dart';
import 'package:t_store/features/shop/presentation/widgets/cart_items_list.dart';

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
          onPressed: () {
            THelperFunctions.navigateToScreen(context, const CheckoutView());
          },
          child: const Text("Checkout \$175"),
        ),
      ),
      appBar: CustomAppBar(
        appBarModel: AppBarModel(
          title: Text("Cart", style: Theme.of(context).textTheme.headlineSmall),
          hasArrowBack: true,
        ),
      ),
      body: const Padding(
        padding: EdgeInsets.all(TSizes.defaultSpace),
        child: CartItemsList(),
      ),
    );
  }
}

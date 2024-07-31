import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/app_bar_view_model.dart';
import 'package:t_store/core/common/view_models/circular_container_view_model.dart';
import 'package:t_store/core/common/view_models/success_view_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/common/widgets/circular_container.dart';
import 'package:t_store/core/common/widgets/navigation_menu.dart';
import 'package:t_store/core/common/widgets/success_view.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/widgets/billing_address_section.dart';
import 'package:t_store/features/shop/presentation/widgets/billing_amount_sction.dart';
import 'package:t_store/features/shop/presentation/widgets/billing_payment_section.dart';
import 'package:t_store/features/shop/presentation/widgets/cart_items_list.dart';
import 'package:t_store/features/shop/presentation/widgets/coupon_code.dart';

class CheckoutView extends StatelessWidget {
  const CheckoutView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () {
            THelperFunctions.navigateToScreen(
                context,
                SuccessView(
                  successModel: SuccessModel(
                    onPressed: () {
                      THelperFunctions.navigateReplacementToScreen(
                          context, const NavigationMenu());
                    },
                    image: TImages.successfulPaymentIcon,
                    buttonText: "Done",
                    subTitle: "You Item Will Be Shipped Soon!",
                    title: "Payment Successful",
                  ),
                ));
          },
          child: const Text("Checkout \$175"),
        ),
      ),
      appBar: CustomAppBar(
          appBarModel: AppBarModel(
              hasArrowBack: true,
              title: Text(
                "Order Review",
                style: Theme.of(context).textTheme.headlineSmall,
              ))),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              const CartItemsList(
                showAddRemoveButtons: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const CouponCode(),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              CircularContainer(
                  circularContainerModel: CircularContainerModel(
                      showBorder: true,
                      padding: const EdgeInsets.all(TSizes.md),
                      color: dark ? TColors.black : TColors.white,
                      child: const Column(
                        children: [
                          BillingAmountSection(),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Divider(),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          BillingPaymentSection(),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          Divider(),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          BillingAddressSection()
                        ],
                      ))),
            ],
          ),
        ),
      ),
    );
  }
}

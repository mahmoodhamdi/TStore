import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/models/brand_card_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/common/widgets/brand_card.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/shop/presentation/widgets/sortable_products.dart';

class BrandProductsView extends StatelessWidget {
  const BrandProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarModel: AppBarModel(title: const Text("Nike"), hasArrowBack: true),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            BrandCard(
                brandCardModel: BrandCardModel(
                    productCount: 5,
                    showBorder: true,
                    brandName: "Nike",
                    image: TImages.nikeLogo)),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            const SortableProducts(),
          ],
        ),
      )),
    );
  }
}

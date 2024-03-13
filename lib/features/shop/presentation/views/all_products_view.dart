import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/models/grid_layout_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';

class AllProductsView extends StatelessWidget {
  const AllProductsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        appBarModel:
            AppBarModel(title: const Text("All Products"), hasArrowBack: true),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            DropdownButtonFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Iconsax.sort),
              ),
              items: [
                "name",
                "High To Low",
                "Low To High",
                "Sales",
                "Newest",
              ]
                  .map((e) => DropdownMenuItem(
                        value: e,
                        child: Text(e),
                      ))
                  .toList(),
              onChanged: (value) => {},
            ),
            const SizedBox(
              height: TSizes.spaceBtwSections,
            ),
            GridLayout(
                gridLayoutModel: GridLayoutModel(
              itemCount: 10,
              itemBuilder: (context, index) {
                return const VerticalProductCard();
              },
            ))
          ],
        ),
      )),
    );
  }
}

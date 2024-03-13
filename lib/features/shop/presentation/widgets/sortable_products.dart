import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/grid_layout_model.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';

class SortableProducts extends StatelessWidget {
  const SortableProducts({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButtonFormField(

          decoration: const InputDecoration(
            prefixIcon: Icon(Iconsax.sort),
          ),
value: "name",
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
    );
  }
}

import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/view_models/grid_layout_view_model.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';
import 'package:t_store/features/shop/domain/entities/product_entity.dart';

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
            return VerticalProductCard(
              product: ProductEntity(
                  id: index,
                  title: "Product $index",
                  price: 100,
                  images: const ["https://picsum.photos/200"],
                  category: "Category $index",
                  description: "Description $index",
                  rating: 4.5,
                  availabilityStatus: "",
                  brand: "  Brand $index",
                  createdAt: DateTime.now(),
                  discountPercentage: 0,
                  returnPolicy: "Return Policy $index",
                  reviews: const [],
                  shippingInformation: "",
                  stock: 5,
                  tags: const [],
                  thumbnail: "",
                  warrantyInformation: ""),
            );
          },
        ))
      ],
    );
  }
}

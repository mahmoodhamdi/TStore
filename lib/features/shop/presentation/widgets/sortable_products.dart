import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/view_models/grid_layout_view_model.dart';
import 'package:t_store/core/common/widgets/product_shimmer.dart';
import 'package:t_store/core/common/widgets/vertical_product_card.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';
import 'package:t_store/features/shop/presentation/controller/shop_cubit.dart';

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
          value: context.read<ShopCubit>().sortBy,
          items: context
              .read<ShopCubit>()
              .sortByList
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (value) => {
            context.read<ShopCubit>().sortBy = value.toString(),
            BlocProvider.of<ShopCubit>(context).getSortedProducts(
              sortBy: value.toString(),
              sortType: "desc",
            )
          },
        ),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        BlocBuilder<ShopCubit, ShopState>(builder: (context, state) {
          if (state is ShopSortedProductsLoaded) {
            return GridLayout(
                gridLayoutModel: GridLayoutModel(
              itemCount: state.productsList.length,
              itemBuilder: (context, index) {
                return VerticalProductCard(
                  product: state.productsList[index],
                );
              },
            ));
          } else if (state is ShopError) {
            return Text(state.error.message);
          }

          return const ProductShimmer();
        }),
      ],
    );
  }
}

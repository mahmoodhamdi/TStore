import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/cubits/navigation_menu_cubit/navigation_menu_cubit.dart';
import 'package:t_store/core/models/app_bar_model.dart';
import 'package:t_store/core/models/circular_icon_model.dart';
import 'package:t_store/core/models/grid_layout_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/widgets/app_bar.dart';
import 'package:t_store/core/widgets/circular_icon.dart';
import 'package:t_store/core/widgets/vertical_product_card.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
        appBar: CustomAppBar(
          appBarModel: AppBarModel(
            actions: [
              CircularIcon(
                circularIconModel: CircularIconModel(
                    color: dark ? TColors.white : TColors.dark,
                    icon: Iconsax.add,
                    onPressed: () =>
                        context.read<NavigationMenuCubit>().changeIndex(0)),
              )
            ],
            title: Text("Wishlist",
                style: Theme.of(context).textTheme.headlineMedium),
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                GridLayout(
                  gridLayoutModel: GridLayoutModel(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const VerticalProductCard();
                    },
                   ),
                ),
              ],
            ),
          ),
        ));
  }
}

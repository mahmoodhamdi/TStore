import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/models/app_bar_model.dart';
import 'package:t_store/core/models/circular_icon_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/widgets/app_bar.dart';
import 'package:t_store/core/widgets/circular_icon.dart';
import 'package:t_store/features/shop/presentation/views/store/store_view.dart';

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
                onPressed: () => THelperFunctions.navigateToScreen(
                  context,
                  const StoreView(),
                ),
              ),
            )
          ],
          title: Text("Wishlist",
              style: Theme.of(context).textTheme.headlineMedium),
        ),
      ),
    );
  }
}

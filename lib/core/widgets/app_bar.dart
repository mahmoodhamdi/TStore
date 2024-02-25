import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/models/app_bar_model.dart';
import 'package:t_store/core/utils/constants/sizes.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.appBarModel});
  final AppBarModel appBarModel;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.md),
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: appBarModel.hasArrowBack!
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Iconsax.arrow_left),
              )
            : appBarModel.leadingIcon != null
                ? IconButton(
                    onPressed: () {
                      appBarModel.leadingOnPressed!();
                    },
                    icon: Icon(appBarModel.leadingIcon),
                  )
                : null,
        title: appBarModel.title,
        actions: appBarModel.actions,
        centerTitle: appBarModel.centerTitle,
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

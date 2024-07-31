import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/view_models/app_bar_view_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/device/device_utility.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.appBarModel});
  final AppBarModel appBarModel;
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: appBarModel.padding,
      child: AppBar(
        automaticallyImplyLeading: false,
        leading: appBarModel.hasArrowBack!
            ? IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: Icon(Iconsax.arrow_left,
                    color: dark ? TColors.white : TColors.black),
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
  Size get preferredSize => Size.fromHeight(TDeviceUtils.getAppBarHeight());
}

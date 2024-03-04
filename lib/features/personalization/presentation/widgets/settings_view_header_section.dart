import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/models/user_profile_tile_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/common/widgets/user_profile_tile.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';

class SettingsViewHeaderSection extends StatelessWidget {
  const SettingsViewHeaderSection({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomAppBar(
          appBarModel: AppBarModel(
              title: Text(
            TTexts.account,
            style: Theme.of(context)
                .textTheme
                .headlineMedium!
                .apply(color: TColors.white),
          )),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
        const UserProfileTile(
          userProfileTileModel: UserProfileTileModel(
              title: "Mahmoud Hamdy",
              subtitle: "hmdy7486@gmail.com",
              trailing: Iconsax.edit,
              leading: TImages.user),
        ),
        const SizedBox(height: TSizes.spaceBtwSections),
      ],
    );
  }
}

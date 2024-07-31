import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/view_models/app_bar_view_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/personalization/presentation/view_models/user_profile_tile_model.dart';
import 'package:t_store/features/personalization/presentation/views/profile_view.dart';
import 'package:t_store/features/personalization/presentation/widgets/user_profile_tile.dart';

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
        UserProfileTile(
          userProfileTileModel: UserProfileTileModel(
              title: "Mahmoud Hamdy",
              subtitle: "hmdy7486@gmail.com",
              onTap: () => THelperFunctions.navigateToScreen(
                  context, const ProfileView()),
              trailing: Iconsax.edit,
              leading: TImages.user),
        ),
        const SizedBox(height: TSizes.spaceBtwSections * 1.2),
      ],
    );
  }
}

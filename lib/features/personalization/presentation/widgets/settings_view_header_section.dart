import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/data/repositories/auth_repo_impl.dart';
import 'package:t_store/features/personalization/presentation/models/user_profile_tile_model.dart';
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
              isNetworkImage: cachedUserData!.image != null,
              title: cachedUserData!.username,
              subtitle: cachedUserData!.email,
              onTap: () => THelperFunctions.navigateToScreen(
                  context, const ProfileView()),
              trailing: Iconsax.edit,
              leading: cachedUserData!.image ?? TImages.user),
        ),
        const SizedBox(height: TSizes.spaceBtwSections * 1.2),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/auth/presentation/views/login/login_view.dart';
import 'package:t_store/features/personalization/presentation/models/profile_entity_tile_model.dart';
import 'package:t_store/features/personalization/presentation/widgets/personal_information_section.dart';
import 'package:t_store/features/personalization/presentation/widgets/profile_information_section.dart';
import 'package:t_store/features/personalization/presentation/widgets/space_btw_sections_with_divider.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    final List<ProfileEntityTileModel> profileInformation = [
      ProfileEntityTileModel(
        title: "Name",
        value: "John Doe",
        onTap: () {},
      ),
      const ProfileEntityTileModel(
        title: "Username",
        value: "Elashwah Hamdi",
      ),
    ];
    final List<ProfileEntityTileModel> personalInformation = [
      ProfileEntityTileModel(
        trailing: Iconsax.copy,
        title: "User ID",
        value: "21-02064",
        onTap: () {},
      ),
      const ProfileEntityTileModel(
        title: "Email",
        value: "hmdy7486@gmail.com",
      ),
      const ProfileEntityTileModel(
        title: "Phone Number",
        value: "+201019793768",
      ),
      const ProfileEntityTileModel(
        title: "Gender",
        value: "Male",
      ),
      const ProfileEntityTileModel(
        title: "Date Of Birth",
        value: "13/01/2003",
      ),
    ];
    return Scaffold(
      appBar: CustomAppBar(
        appBarModel:
            AppBarModel(title: const Text("Profile"), hasArrowBack: true),
      ),
      body: SingleChildScrollView(
          child: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: Column(
          children: [
            ProfileInformationSection(profileInformation: profileInformation),
            const SpaceBetweenSectionsWithDivider(),
            PersonalInformationSection(
                personalInformation: personalInformation),
            const SpaceBetweenSectionsWithDivider(),
            TextButton(
                onPressed: () {
                  context.read<AuthCubit>().deleteAccount();
                  THelperFunctions.showSnackBar(
                    type: SnackBarType.info,
                    context: context,
                    message: "Your Account Has Been Deleted Successfully",
                  );
                  THelperFunctions.navigateToScreen(context, const LoginView());
                },
                child: const Text(
                  "Delete Account",
                  style: TextStyle(color: TColors.error),
                )),
            const SizedBox(
              height: TSizes.spaceBtwItems / 1.5,
            ),
          ],
        ),
      )),
    );
  }
}

// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/common/models/rounded_image_model.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/rounded_image.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/enums.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:t_store/features/personalization/presentation/models/profile_entity_tile_model.dart';
import 'package:t_store/features/personalization/presentation/widgets/profile_entity_tile_list.dart';
import 'package:t_store/features/personalization/presentation/widgets/space_btw_sections_with_divider.dart';

class ProfileInformationSection extends StatelessWidget {
  const ProfileInformationSection({
    super.key,
    required this.profileInformation,
  });

  final List<ProfileEntityTileModel> profileInformation;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(listener: (context, state) {
      if (state is AuthImageUploading) {
        THelperFunctions.showSnackBar(
          type: SnackBarType.info,
          message: "Uploading...",
          context: context,
        );
      }
      if (state is AuthImageUploaded) {
        THelperFunctions.showSnackBar(
          type: SnackBarType.success,
          message: "Image Uploaded",
          context: context,
        );
      }
    }, builder: (context, state) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            child: Column(
              children: [
                RoundedImage(
                  roundedImageModel: RoundedImageModel(
                    isNetworkImage:
                        context.read<AuthCubit>().userModel!.image != null,
                    image: context.read<AuthCubit>().userModel!.image ??
                        TImages.user,
                    width: 80,
                    height: 80,
                    onTap: () {},
                  ),
                ),
                TextButton(
                  onPressed: () {
                    context.read<AuthCubit>().uploadImage();
                  },
                  child: const Text("Change Profile Picture"),
                ),
              ],
            ),
          ),
          const SpaceBetweenSectionsWithDivider(),
          SectionHeading(
            sectionHeadingModel: SectionHeadingModel(
              title: "Profile Information",
              showActionButton: false,
            ),
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems / 1.5,
          ),
          ProfileEntityTileList(
            profileEntityTileModelList: profileInformation,
          ),
        ],
      );
    });
  }
}

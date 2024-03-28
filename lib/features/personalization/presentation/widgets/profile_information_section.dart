import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/rounded_image_model.dart';
import 'package:t_store/core/common/models/section_heading_model.dart';
import 'package:t_store/core/common/widgets/rounded_image.dart';
import 'package:t_store/core/common/widgets/section_heading.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
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
    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: Column(
            children: [
              RoundedImage(
                roundedImageModel: RoundedImageModel(
                  image: TImages.user,
                  width: 80,
                  height: 80,
                  onTap: () {},
                ),
              ),
              TextButton(
                onPressed: () {},
                child: const Text("Change Profile Picture"),
              ),
            ],
          ),
        ),
        const SpaceBetweenSectionsWithDivider(),
        SectionHeading(
            sectionHeadingModel: SectionHeadingModel(
                title: "Profile Information", showActionButton: false)),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        ProfileEntityTileList(profileEntityTileModelList: profileInformation),
      ],
    );
  }
}

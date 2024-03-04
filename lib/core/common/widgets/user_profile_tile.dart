

import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/rounded_image_model.dart';
import 'package:t_store/core/common/models/user_profile_tile_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/common/widgets/rounded_image.dart';

class UserProfileTile extends StatelessWidget {
  const UserProfileTile({
    super.key,
    required this.userProfileTileModel,
  });
  final UserProfileTileModel userProfileTileModel;
  @override
  Widget build(BuildContext context) {
    return ListTile(
        leading: RoundedImage(
            roundedImageModel: RoundedImageModel(
                image: userProfileTileModel.leading,
                width: 50,
                height: 50,
                padding: EdgeInsets.zero)),
        title: Text(userProfileTileModel.title,
            style: Theme.of(context).textTheme.headlineMedium!.apply(
                  color: TColors.white,
                )),
        subtitle: Text(
          userProfileTileModel.subtitle,
          style: Theme.of(context).textTheme.bodyMedium!.apply(
                color: TColors.white,
              ),
        ),
        trailing: IconButton(
          onPressed: null,
          icon: Icon(
            userProfileTileModel.trailing,
            color: TColors.white,
          ),
        ));
  }
}

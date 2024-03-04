import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/personalization/presentation/models/profile_entity_tile_model.dart';

class ProfileEntityTile extends StatelessWidget {
  const ProfileEntityTile({
    super.key,
    required this.profileEntityTileModel,
  });
  final ProfileEntityTileModel profileEntityTileModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: profileEntityTileModel.onTap,
      child: Padding(
        padding:
            const EdgeInsets.symmetric(vertical: TSizes.spaceBtwItems / 1.5),
        child: Row(
          children: [
            Expanded(
              flex: 3,
              child: Text(
                profileEntityTileModel.title,
                style: Theme.of(context).textTheme.bodySmall,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                profileEntityTileModel.value,
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Expanded(
              child: Icon(
                profileEntityTileModel.trailing,
                size: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/core/models/rounded_image_model.dart';

class RoundedImage extends StatelessWidget {
  const RoundedImage({
    super.key,
    required this.roundedImageModel,
  });
  final RoundedImageModel roundedImageModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: roundedImageModel.onTap,
      child: Container(
        width: roundedImageModel.width,
        height: roundedImageModel.height,
        decoration: BoxDecoration(
          border: roundedImageModel.border,
          borderRadius: BorderRadius.circular(roundedImageModel.borderRadius),
          color: roundedImageModel.backgroundColor,
        ),
        child: ClipRRect(
            borderRadius: roundedImageModel.applyImageRadius
                ? BorderRadius.circular(roundedImageModel.borderRadius)
                : BorderRadius.zero,
            child: Image(
              image: roundedImageModel.isNetworkImage
                  ? CachedNetworkImageProvider(roundedImageModel.image)
                  : AssetImage(
                      roundedImageModel.image,
                    ) as ImageProvider,
              fit: roundedImageModel.fit,
            )),
      ),
    );
  }
}


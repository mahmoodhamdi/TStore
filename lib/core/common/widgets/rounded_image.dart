import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/rounded_image_view_model.dart';

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
            child: roundedImageModel.isNetworkImage
                ? CachedNetworkImage(
                    imageUrl: roundedImageModel.image,
                    placeholderFadeInDuration: Duration.zero,
                    placeholder: (context, url) => SizedBox(
                        width: roundedImageModel.width,
                        height: roundedImageModel.height
                        
                        ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                    color: roundedImageModel.overlayColor,
                    fit: roundedImageModel.fit,
                  )
                : Image(
                    image: AssetImage(
                      roundedImageModel.image,
                    ),
                    color: roundedImageModel.overlayColor,
                    fit: roundedImageModel.fit,
                  )),
      ),
    );
  }
}

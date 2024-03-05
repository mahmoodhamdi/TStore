import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/widgets/product_image_slider.dart';
import 'package:t_store/features/shop/presentation/widgets/product_metadata.dart';
import 'package:t_store/features/shop/presentation/widgets/rating_and_share.dart';

class ProductDetailsView extends StatelessWidget {
  const ProductDetailsView({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return const Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        ProductImageSlider(),
        Padding(
          padding: EdgeInsets.fromLTRB(
              TSizes.defaultSpace, 0, TSizes.defaultSpace, TSizes.defaultSpace),
          child: Column(
            children: [RatingAndShare(), ProductMetadata()],
          ),
        )
      ],
    )));
  }
}

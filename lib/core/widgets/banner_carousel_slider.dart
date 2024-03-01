import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:t_store/core/cubits/banner_carousel_slider_cubit_cubit/banner_carousel_slider_cubit.dart';
import 'package:t_store/core/models/rounded_image_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/widgets/circular_container.dart';
import 'package:t_store/core/widgets/rounded_image.dart';
import 'package:t_store/core/models/circular_container_model.dart';

class BannerCarouselSlider extends StatelessWidget {
  const BannerCarouselSlider({
    super.key,
    required this.images,
  });
  final List<String> images;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannerCarouselSliderCubit, BannerCarouselSliderState>(
      builder: (context, state) {
        return Column(
          children: [
            CarouselSlider(
              options: CarouselOptions(
                viewportFraction: 1,
                onPageChanged: (index, reason) => context
                    .read<BannerCarouselSliderCubit>()
                    .changeIndex(index),
              ),
              items: List.generate(
                images.length,
                (index) => RoundedImage(
                  roundedImageModel: RoundedImageModel(
                    image: images[index],
                  ),
                ),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                  images.length,
                  (index) => CircularContainer(
                        circularContainerModel: CircularContainerModel(
                          margin: const EdgeInsets.only(right: TSizes.sm),
                          width: 20,
                          height: 4,
                          color: index ==
                                  context
                                      .read<BannerCarouselSliderCubit>()
                                      .selectedIndex
                              ? TColors.primary
                              : TColors.grey,
                        ),
                      )),
            )
          ],
        );
      },
    );
  }
}

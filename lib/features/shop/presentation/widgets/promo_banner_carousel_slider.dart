import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:t_store/core/common/widgets/banner_carousel_slider.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/cubit/banners_cubit.dart';
import 'package:t_store/features/shop/presentation/cubit/banners_state.dart';

class PromoBannerCarouselSlider extends StatefulWidget {
  const PromoBannerCarouselSlider({
    super.key,
  });

  @override
  State<PromoBannerCarouselSlider> createState() =>
      _PromoBannerCarouselSliderState();
}

class _PromoBannerCarouselSliderState extends State<PromoBannerCarouselSlider> {
  @override
  void initState() {
    super.initState();
    context.read<BannersCubit>().getBanners();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BannersCubit, BannersState>(
      builder: (context, state) {
        if (state is BannersLoaded) {
          if (state.banners.isEmpty) {
            // Fallback to static images if no banners in database
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: BannerCarouselSlider(
                images: TImages.promoBannerImages,
              ),
            );
          }
          // Filter to show only currently active banners
          final activeBanners =
              state.banners.where((b) => b.isCurrentlyActive).toList();
          if (activeBanners.isEmpty) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
              child: BannerCarouselSlider(
                images: TImages.promoBannerImages,
              ),
            );
          }
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: BannerCarouselSlider(
              images: activeBanners.map((b) => b.imageUrl).toList(),
            ),
          );
        }
        if (state is BannersError) {
          // Fallback to static images on error
          return Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
            child: BannerCarouselSlider(
              images: TImages.promoBannerImages,
            ),
          );
        }
        // Loading state
        return const _BannerShimmer();
      },
    );
  }
}

class _BannerShimmer extends StatelessWidget {
  const _BannerShimmer();

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
      child: Shimmer.fromColors(
        baseColor: dark ? Colors.grey[850]! : Colors.grey[300]!,
        highlightColor: dark ? Colors.grey[700]! : Colors.grey[100]!,
        child: Container(
          height: 180,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(TSizes.cardRadiusLg),
          ),
        ),
      ),
    );
  }
}

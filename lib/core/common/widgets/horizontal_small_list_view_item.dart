import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/horizontal_small_list_view_item_view_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/views/sub_category_view.dart';

class HorizontalSmallListViewItem extends StatelessWidget {
  const HorizontalSmallListViewItem({
    super.key,
    required this.item,
  });

  final HorizontalSmallListViewItemModel item;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () =>
          THelperFunctions.navigateToScreen(context, const SubCategoryView()),
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.defaultSpace),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              height: 56,
              width: 56,
              padding: const EdgeInsets.all(TSizes.sm),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(100),
                ),
                color: item.backgroundColor ??
                    (dark ? TColors.black : TColors.white),
              ),
              child: Center(
                child: Image(
                    image: AssetImage(item.image),
                    fit: BoxFit.cover,
                    color: dark ? TColors.white : TColors.black),
              ),
            ),
            const SizedBox(height: TSizes.spaceBtwItems / 2),
            Text(item.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.labelMedium!.apply(
                      color: item.textColor,
                    )),
          ],
        ),
      ),
    );
  }
}

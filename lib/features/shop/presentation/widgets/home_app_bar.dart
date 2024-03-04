import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/app_bar_model.dart';
import 'package:t_store/core/common/models/cart_counter_icon_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/common/widgets/cart_counter_icon.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      appBarModel: AppBarModel(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              TTexts.homeAppbarTitle,
              style: Theme.of(context).textTheme.labelMedium!.apply(
                    color: TColors.grey,
                  ),
            ),
            Text(
              TTexts.homeAppbarSubTitle,
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: TColors.white,
                  ),
            ),
          ],
        ),
        actions: [
          CartCounterIcon(
            cartCounterIconModel: CartCounterIconModel(
              color: TColors.white,
              onPressed: () {},
            ),
          ),
        ],
      ),
    );
  }
}

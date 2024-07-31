import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:t_store/core/common/view_models/cart_counter_icon_view_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';

class CartCounterIcon extends StatelessWidget {
  const CartCounterIcon({
    super.key,
    required this.cartCounterIconModel,
  });
  final CartCounterIconModel cartCounterIconModel;
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        IconButton(
          onPressed: cartCounterIconModel.onPressed,
          icon: Icon(
            Iconsax.shopping_bag,
            color: cartCounterIconModel.color,
          ),
        ),
        Positioned(
          top: 0,
          right: 0,
          child: Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: TColors.black,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                cartCounterIconModel.count.toString(),
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.white, fontSizeFactor: .8),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/features/shop/presentation/widgets/order_list_item.dart';

class OrdersList extends StatelessWidget {
  const OrdersList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        shrinkWrap: true,
        itemBuilder: (context, index) => const OrderListItem(),
        separatorBuilder: (context, index) => const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
        itemCount: 6);
  }
}

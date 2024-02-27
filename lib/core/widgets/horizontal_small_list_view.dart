import 'package:flutter/material.dart';
import 'package:t_store/core/models/horizontal_small_list_view_item_model.dart';
import 'package:t_store/core/widgets/horizontal_small_list_view_item.dart';

class HorizontalSmallListView extends StatelessWidget {
  const HorizontalSmallListView({
    super.key,
    required this.items,
  });
  final List<HorizontalSmallListViewItemModel> items;
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: items.length,
        itemBuilder: (context, index) {
          return HorizontalSmallListViewItem(item: items[index]);
        });
  }
}

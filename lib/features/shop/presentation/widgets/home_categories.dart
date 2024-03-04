import 'package:flutter/material.dart';
import 'package:t_store/core/common/models/horizontal_small_list_view_item_model.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/common/widgets/horizontal_small_list_view.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    const List<String> categoriesTitles = TTexts.categories;
    const List<String> categoriesImages = TImages.categoryIcons;

    final List<HorizontalSmallListViewItemModel> items = List.generate(
        categoriesTitles.length,
        (index) => HorizontalSmallListViewItemModel(
              title: categoriesTitles[index],
              image: categoriesImages[index],
            ));

    return SizedBox(
      height: 100,
      child: HorizontalSmallListView(items: items),
    );
  }
}

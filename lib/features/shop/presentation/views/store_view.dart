import 'package:flutter/material.dart';
import 'package:t_store/core/common/view_models/app_bar_view_model.dart';
import 'package:t_store/core/common/view_models/brand_card_view_model.dart';
import 'package:t_store/core/common/view_models/brand_showcase_view_model.dart';
import 'package:t_store/core/common/view_models/cart_counter_icon_view_model.dart';
import 'package:t_store/core/common/view_models/category_tab_view_model.dart';
import 'package:t_store/core/common/view_models/tab_bar_view_model.dart';
import 'package:t_store/core/common/widgets/app_bar.dart';
import 'package:t_store/core/common/widgets/cart_counter_icon.dart';
import 'package:t_store/core/common/widgets/category_tab.dart';
import 'package:t_store/core/common/widgets/tab_bar.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/shop/presentation/views/cart_view.dart';
// [Previous imports remain the same]

class StoreView extends StatelessWidget {
  const StoreView({super.key});

  @override
  Widget build(BuildContext context) {
    const List<String> brandIcons = TImages.brandIcons;
    const List<String> topProducts = TImages.topProducts;
    const List<String> products = TImages.productsImages;
    const List<String> brandTitles = TTexts.brandTitles;
    const List<String> categories = TTexts.categories;

    final dark = THelperFunctions.isDarkMode(context);

    return DefaultTabController(
      length: categories
          .length, // This ensures the controller length matches the number of tabs
      initialIndex: 0,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarModel: AppBarModel(
            title:
                Text("Store", style: Theme.of(context).textTheme.headlineSmall),
            actions: [
              CartCounterIcon(
                cartCounterIconModel: CartCounterIconModel(
                  onPressed: () {
                    THelperFunctions.navigateToScreen(
                        context, const CartView());
                  },
                  color: dark ? TColors.white : TColors.dark,
                ),
              ),
            ],
          ),
        ),
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                // [Previous SliverAppBar properties remain the same]
                bottom: CustomTabBar(
                  tabBarModel: TabBarModel(
                    labelColor: dark ? TColors.white : TColors.primary,
                    tabs: categories
                        .map((category) => Tab(text: category))
                        .toList(),
                  ),
                ),
              )
            ];
          },
          body: TabBarView(
            children: categories
                .map((category) => CategoryTab(
                      categoryTabModel: CategoryTabModel(
                        brandShowcaseModel: BrandShowcaseModel(
                          brandCardModel: BrandCardModel(
                            isVerified: true,
                            image: brandIcons[categories.indexOf(category) %
                                brandIcons.length],
                            brandName: brandTitles[
                                categories.indexOf(category) %
                                    brandTitles.length],
                            showBorder: false,
                            onTap: () {},
                            productCount: 25,
                          ),
                          topThreeProductsOfBrand: topProducts,
                        ),
                        products: products,
                        categoryTitle: category,
                      ),
                    ))
                .toList(),
          ),
        ),
      ),
    );
  }
}

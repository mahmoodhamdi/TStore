import 'package:flutter/material.dart';
import 'package:t_store/core/models/app_bar_model.dart';
import 'package:t_store/core/models/brand_card_model.dart';
import 'package:t_store/core/models/brand_showcase_model.dart';
import 'package:t_store/core/models/cart_counter_icon_model.dart';
import 'package:t_store/core/models/category_tab_model.dart';
import 'package:t_store/core/models/grid_layout_model.dart';
import 'package:t_store/core/models/search_container_model.dart';
import 'package:t_store/core/models/section_heading_model.dart';
import 'package:t_store/core/models/tab_bar_model.dart';
import 'package:t_store/core/utils/constants/colors.dart';
import 'package:t_store/core/utils/constants/image_strings.dart';
import 'package:t_store/core/utils/constants/sizes.dart';
import 'package:t_store/core/utils/constants/text_strings.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/core/widgets/app_bar.dart';
import 'package:t_store/core/widgets/brand_card.dart';
import 'package:t_store/core/widgets/cart_counter_icon.dart';
import 'package:t_store/core/widgets/category_tab.dart';
import 'package:t_store/core/widgets/search_container.dart';
import 'package:t_store/core/widgets/section_heading.dart';
import 'package:t_store/core/widgets/tab_bar.dart';
import 'package:t_store/features/auth/presentation/widgets/grid_layout.dart';

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
      length: TTexts.categories.length,
      initialIndex: 0,
      child: Scaffold(
        appBar: CustomAppBar(
          appBarModel: AppBarModel(
            title: Text(
              "Store",
              style: Theme.of(context).textTheme.headlineSmall!.apply(
                    color: TColors.white,
                  ),
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
        ),
        body: NestedScrollView(
            headerSliverBuilder: (context, innerBoxIsScrolled) {
              return [
                SliverAppBar(
                    pinned: true,
                    floating: true,
                    expandedHeight: 440,
                    automaticallyImplyLeading: false,
                    backgroundColor: dark ? TColors.black : TColors.white,
                    flexibleSpace: Padding(
                      padding: const EdgeInsets.all(TSizes.defaultSpace),
                      child: ListView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        children: [
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          SearchContainer(
                            searchContainerModel: SearchContainerModel(
                              padding: EdgeInsets.zero,
                              showBackground: false,
                              showBorder: true,
                            ),
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          SectionHeading(
                              sectionHeadingModel: SectionHeadingModel(
                            title: "Featured Brands",
                            actionButtonOnPressed: () {},
                            showActionButton: true,
                          )),
                          const SizedBox(
                            height: TSizes.spaceBtwItems / 1.5,
                          ),
                          GridLayout(
                              gridLayoutModel: GridLayoutModel(
                            itemCount: 4,
                            itemBuilder: (context, index) {
                              return BrandCard(
                                brandCardModel: BrandCardModel(
                                  isVerified: true,
                                  image: brandIcons[index],
                                  brandName: brandTitles[index],
                                  showBorder: false,
                                  onTap: () {},
                                  productCount: 5,
                                ),
                              );
                            },
                            mainAxisExtent: 80,
                          )),
                        ],
                      ),
                    ),
                    bottom: CustomTabBar(
                      tabBarModel: TabBarModel(
                          labelColor: dark ? TColors.white : TColors.primary,
                          tabs: List.generate(
                              categories.length,
                              (index) => Tab(
                                    text: categories[index],
                                  ))),
                    ))
              ];
            },
            body: TabBarView(
              children: List.generate(
                  10,
                  (index) => CategoryTab(
                        categoryTabModel: CategoryTabModel(
                          brandShowcaseModel: BrandShowcaseModel(
                            brandCardModel: BrandCardModel(
                              isVerified: true,
                              image: brandIcons[index],
                              brandName: brandTitles[index],
                              showBorder: false,
                              onTap: () {},
                              productCount: 25,
                            ),
                            topThreeProductsOfBrand: topProducts,
                          ),
                          products: products,
                          categoryTitle: categories[index],
                        ),
                      )),
            )),
      ),
    );
  }
}

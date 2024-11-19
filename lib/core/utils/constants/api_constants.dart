class ApiConstants {
  static const String dummyBaseUrl = 'https://dummyjson.com/products';

  static String getDummyProducts({int page = 1, int limit = 10}) =>
      '$dummyBaseUrl?limit=$limit&skip=${(page - 1) * limit}';
  static String getDummyProductById(int id) => '$dummyBaseUrl/$id';
  static String getDummyCategories() => '$dummyBaseUrl/categories';
  static String getDummyProductsBySearch({String? search}) =>
      '$dummyBaseUrl/search?q=$search';
  static String getDummyProductsByCategory({required String categoryName}) =>
      '$dummyBaseUrl/category/$categoryName';
  static String getDummySortedProducts(
          {required String sortBy, required String sortType}) =>
      '$dummyBaseUrl?sortBy=$sortBy&order=$sortType';
  static const baseURL = 'https://master-market.masool.net/api/';
  static const registerUrl = '${baseURL}register';
  static const loginUrl = '${baseURL}login';
  static const userProfileUrl = '${baseURL}profile';
  static const logoutUrl = '${baseURL}user_delete/0';
  static const forgotPasswordUrl = '${baseURL}forget_pass_user';
  static const resetPasswordUrl = '${baseURL}change_password';
  // Additional URLs from the collection
  static const updateProfileUrl = '${baseURL}update_profile/0';
  static const userOrdersUrl = '${baseURL}user_orders';
  static const getUserOrdersUrl = '${baseURL}user_orders/t/ar';
  static const userFavoritesUrl = '${baseURL}user_favorite/t/ar';
  static const addUserFavoriteUrl = '${baseURL}user_favorite';
  static const categoriesUrl = '${baseURL}categories/t/ar/0/0';
  static const sliderUrl = '${baseURL}advertising/t/ar/0';
  static const categoriesWithSubUrl =
      '${baseURL}categories/get_with_sub/ar/0/0';
  static const productsInCategoriesUrl =
      '${baseURL}categories/get_with_product_sub/ar/0/0';

  static const imageUrl = 'https://master-market.masool.net/uploads/';
  static getProductsByPageUrl(String page) =>
      '${baseURL}products/t/ar/0/0/0?page=$page';
  static getProductsBySearchUrl(String term) =>
      "${baseURL}products/t/ar/0/0/0?search=$term";
}

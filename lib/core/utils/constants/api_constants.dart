class ApiConstants {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1/';
  static const String productsFilter =
      'https://api.escuelajs.co/api/v1/products/?';
  static String getProducts() => '${baseUrl}products';
  static String getProductById(int id) => '${baseUrl}products/$id';
  static String getCategories() => '${baseUrl}categories';
  static String getCategoryById(int id) => '${baseUrl}categories/$id';
  static String getUsers() => '${baseUrl}users';
  static String getUserById(String id) => '${baseUrl}users/$id';
  static String login() => '${baseUrl}auth/login';
  static String getProfile() => '${baseUrl}auth/profile';
  static String getProductsByCategory({required int categoryId}) =>
      '${baseUrl}products/?categoryId=$categoryId';
  static String getProductsByCategoryAndSearch(
          {required int categoryId, String? search}) =>
      '${productsFilter}title=$search&categoryId=$categoryId';

  static String getProductsBySearch({String? search}) =>
      '${productsFilter}title=$search';
  static String getProductsByFilters(
          {int? categoryId = 0,
          String? search = "",
          num? maxPrice = 1000000,
          num? minPrice = 0}) =>
      '${productsFilter}categoryId=$categoryId&title=$search&maxPrice=$maxPrice&minPrice=$minPrice';
  static String getProductsByPriceRange(
          {num? maxPrice = 1000000, num? minPrice = 0}) =>
      '${productsFilter}maxPrice=$maxPrice&minPrice=$minPrice';

}

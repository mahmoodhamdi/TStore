class ApiConstants {
  static const String baseUrl = 'https://dummyjson.com/products';
  static String getProducts({int page = 1, int limit = 10}) =>
      '$baseUrl?limit=$limit&skip=${(page - 1) * limit}';
  static String getProductById(int id) => '$baseUrl/$id';
  static String getCategories() => '$baseUrl/categories';
  static String getProductsBySearch({String? search}) =>
      '$baseUrl/search?q=$search';
  static String getProductsByCategory({required String categoryName}) =>
      '$baseUrl/category/$categoryName';
  static String getSortedProducts(
          {required String sortBy, required String sortType}) =>
      '$baseUrl?sortBy=$sortBy&order=$sortType';
}

class ApiConstants {
  static const String baseUrl = 'https://api.escuelajs.co/api/v1/';
  static String getProducts() => '${baseUrl}products';
  static String getProductById(String id) => '${baseUrl}products/$id';
  static String getCategories() => '${baseUrl}categories';
  static String getCategoryById(String id) => '${baseUrl}categories/$id';
  static String getUsers() => '${baseUrl}users';
  static String getUserById(String id) => '${baseUrl}users/$id';
  static String login() => '${baseUrl}auth/login';
  static String getProfile() => '${baseUrl}auth/profile';
}

/// Supabase Table Names
///
/// Centralized table names to avoid typos and make refactoring easier
class SupabaseTables {
  // User related
  static const String profiles = 'profiles';
  static const String addresses = 'addresses';

  // Products related
  static const String categories = 'categories';
  static const String brands = 'brands';
  static const String products = 'products';
  static const String productVariations = 'product_variations';

  // Shopping related
  static const String wishlist = 'wishlist';
  static const String cartItems = 'cart_items';
  static const String coupons = 'coupons';

  // Orders related
  static const String orders = 'orders';
  static const String orderItems = 'order_items';

  // Reviews
  static const String reviews = 'reviews';

  // Marketing
  static const String banners = 'banners';

  // Communication
  static const String chatMessages = 'chat_messages';
  static const String notifications = 'notifications';
}

/// Supabase Column Names for common fields
class SupabaseColumns {
  // Common
  static const String id = 'id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';

  // User related
  static const String userId = 'user_id';
  static const String email = 'email';
  static const String fullName = 'full_name';
  static const String phone = 'phone';
  static const String avatarUrl = 'avatar_url';

  // Product related
  static const String productId = 'product_id';
  static const String categoryId = 'category_id';
  static const String brandId = 'brand_id';
  static const String title = 'title';
  static const String description = 'description';
  static const String price = 'price';
  static const String salePrice = 'sale_price';
  static const String stock = 'stock';
  static const String thumbnail = 'thumbnail';
  static const String images = 'images';
  static const String isFeatured = 'is_featured';
  static const String isActive = 'is_active';
  static const String rating = 'rating';
  static const String reviewsCount = 'reviews_count';

  // Order related
  static const String orderId = 'order_id';
  static const String orderNumber = 'order_number';
  static const String status = 'status';
  static const String total = 'total';
  static const String quantity = 'quantity';
}

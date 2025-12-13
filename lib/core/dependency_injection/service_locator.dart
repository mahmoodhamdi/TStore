import 'package:get_it/get_it.dart';
import 'package:t_store/core/supabase/supabase_service.dart';

// Auth
import 'package:t_store/features/auth/data/repositories/auth_repository_impl.dart';
import 'package:t_store/features/auth/domain/repositories/auth_repository.dart';
import 'package:t_store/features/auth/domain/usecases/sign_in_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/sign_up_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/sign_out_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/reset_password_usecase.dart';
import 'package:t_store/features/auth/domain/usecases/get_current_user_usecase.dart';
import 'package:t_store/features/auth/presentation/cubit/auth_cubit.dart';

// Products
import 'package:t_store/features/shop/data/repositories/product_repository_impl.dart';
import 'package:t_store/features/shop/domain/repositories/product_repository.dart';
import 'package:t_store/features/shop/domain/usecases/get_products_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/get_product_by_id_usecase.dart';
import 'package:t_store/features/shop/domain/usecases/search_products_usecase.dart';
import 'package:t_store/features/shop/presentation/cubit/products_cubit.dart';

// Categories
import 'package:t_store/features/shop/data/repositories/category_repository_impl.dart';
import 'package:t_store/features/shop/domain/repositories/category_repository.dart';
import 'package:t_store/features/shop/domain/usecases/get_categories_usecase.dart';
import 'package:t_store/features/shop/presentation/cubit/categories_cubit.dart';

// Brands
import 'package:t_store/features/shop/data/repositories/brand_repository_impl.dart';
import 'package:t_store/features/shop/domain/repositories/brand_repository.dart';
import 'package:t_store/features/shop/domain/usecases/get_brands_usecase.dart';
import 'package:t_store/features/shop/presentation/cubit/brands_cubit.dart';

// Banners
import 'package:t_store/features/shop/data/repositories/banner_repository_impl.dart';
import 'package:t_store/features/shop/domain/repositories/banner_repository.dart';
import 'package:t_store/features/shop/domain/usecases/get_banners_usecase.dart';
import 'package:t_store/features/shop/presentation/cubit/banners_cubit.dart';

// Cart
import 'package:t_store/features/cart/data/repositories/cart_repository_impl.dart';
import 'package:t_store/features/cart/domain/repositories/cart_repository.dart';
import 'package:t_store/features/cart/domain/usecases/get_cart_items_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/add_to_cart_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/update_cart_item_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/remove_from_cart_usecase.dart';
import 'package:t_store/features/cart/domain/usecases/clear_cart_usecase.dart';
import 'package:t_store/features/cart/presentation/cubit/cart_cubit.dart';

// Wishlist
import 'package:t_store/features/wishlist/data/repositories/wishlist_repository_impl.dart';
import 'package:t_store/features/wishlist/domain/repositories/wishlist_repository.dart';
import 'package:t_store/features/wishlist/domain/usecases/get_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/domain/usecases/add_to_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/domain/usecases/remove_from_wishlist_usecase.dart';
import 'package:t_store/features/wishlist/presentation/cubit/wishlist_cubit.dart';

// Orders
import 'package:t_store/features/orders/data/repositories/order_repository_impl.dart';
import 'package:t_store/features/orders/domain/repositories/order_repository.dart';
import 'package:t_store/features/orders/domain/usecases/get_orders_usecase.dart';
import 'package:t_store/features/orders/domain/usecases/get_order_by_id_usecase.dart';
import 'package:t_store/features/orders/domain/usecases/create_order_usecase.dart';
import 'package:t_store/features/orders/domain/usecases/cancel_order_usecase.dart';
import 'package:t_store/features/orders/presentation/cubit/orders_cubit.dart';

// Addresses
import 'package:t_store/features/personalization/data/repositories/address_repository_impl.dart';
import 'package:t_store/features/personalization/domain/repositories/address_repository.dart';
import 'package:t_store/features/personalization/domain/usecases/get_addresses_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/add_address_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/update_address_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/delete_address_usecase.dart';
import 'package:t_store/features/personalization/presentation/cubit/addresses_cubit.dart';

// Reviews
import 'package:t_store/features/reviews/data/repositories/review_repository_impl.dart';
import 'package:t_store/features/reviews/domain/repositories/review_repository.dart';
import 'package:t_store/features/reviews/domain/usecases/get_product_reviews_usecase.dart';
import 'package:t_store/features/reviews/domain/usecases/add_review_usecase.dart';
import 'package:t_store/features/reviews/presentation/cubit/reviews_cubit.dart';

// Profile
import 'package:t_store/features/personalization/data/repositories/profile_repository_impl.dart';
import 'package:t_store/features/personalization/domain/repositories/profile_repository.dart';
import 'package:t_store/features/personalization/domain/usecases/get_profile_usecase.dart';
import 'package:t_store/features/personalization/domain/usecases/update_profile_usecase.dart';
import 'package:t_store/features/personalization/presentation/cubit/profile_cubit.dart';

// Chat
import 'package:t_store/features/chat/data/repositories/chat_repository_impl.dart';
import 'package:t_store/features/chat/domain/repositories/chat_repository.dart';
import 'package:t_store/features/chat/presentation/cubit/chat_cubit.dart';

// Notifications
import 'package:t_store/features/notifications/data/repositories/notification_repository_impl.dart';
import 'package:t_store/features/notifications/domain/repositories/notification_repository.dart';
import 'package:t_store/features/notifications/presentation/cubit/notifications_cubit.dart';

final sl = GetIt.instance;

Future<void> setupServiceLocator() async {
  // ==================== Core ====================
  sl.registerLazySingleton<SupabaseService>(() => SupabaseService.instance);

  // ==================== Auth ====================
  // Repository
  sl.registerLazySingleton<AuthRepository>(
    () => AuthRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => SignInUsecase(sl()));
  sl.registerLazySingleton(() => SignUpUsecase(sl()));
  sl.registerLazySingleton(() => SignOutUsecase(sl()));
  sl.registerLazySingleton(() => ResetPasswordUsecase(sl()));
  sl.registerLazySingleton(() => GetCurrentUserUsecase(sl()));

  // Cubit
  sl.registerFactory(() => AuthCubit(
        signInUsecase: sl(),
        signUpUsecase: sl(),
        signOutUsecase: sl(),
        resetPasswordUsecase: sl(),
        getCurrentUserUsecase: sl(),
      ));

  // ==================== Products ====================
  // Repository
  sl.registerLazySingleton<ProductRepository>(
    () => ProductRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetProductsUsecase(sl()));
  sl.registerLazySingleton(() => GetProductByIdUsecase(sl()));
  sl.registerLazySingleton(() => SearchProductsUsecase(sl()));

  // Cubit
  sl.registerFactory(() => ProductsCubit(
        getProductsUsecase: sl(),
        getProductByIdUsecase: sl(),
        searchProductsUsecase: sl(),
      ));

  // ==================== Categories ====================
  // Repository
  sl.registerLazySingleton<CategoryRepository>(
    () => CategoryRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetCategoriesUsecase(sl()));

  // Cubit
  sl.registerFactory(() => CategoriesCubit(getCategoriesUsecase: sl()));

  // ==================== Brands ====================
  // Repository
  sl.registerLazySingleton<BrandRepository>(
    () => BrandRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetBrandsUsecase(sl()));

  // Cubit
  sl.registerFactory(() => BrandsCubit(getBrandsUsecase: sl()));

  // ==================== Banners ====================
  // Repository
  sl.registerLazySingleton<BannerRepository>(
    () => BannerRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetBannersUsecase(sl()));

  // Cubit
  sl.registerFactory(() => BannersCubit(getBannersUsecase: sl()));

  // ==================== Cart ====================
  // Repository
  sl.registerLazySingleton<CartRepository>(
    () => CartRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetCartItemsUsecase(sl()));
  sl.registerLazySingleton(() => AddToCartUsecase(sl()));
  sl.registerLazySingleton(() => UpdateCartItemUsecase(sl()));
  sl.registerLazySingleton(() => RemoveFromCartUsecase(sl()));
  sl.registerLazySingleton(() => ClearCartUsecase(sl()));

  // Cubit
  sl.registerFactory(() => CartCubit(
        getCartItemsUsecase: sl(),
        addToCartUsecase: sl(),
        updateCartItemUsecase: sl(),
        removeFromCartUsecase: sl(),
        clearCartUsecase: sl(),
      ));

  // ==================== Wishlist ====================
  // Repository
  sl.registerLazySingleton<WishlistRepository>(
    () => WishlistRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetWishlistUsecase(sl()));
  sl.registerLazySingleton(() => AddToWishlistUsecase(sl()));
  sl.registerLazySingleton(() => RemoveFromWishlistUsecase(sl()));

  // Cubit
  sl.registerFactory(() => WishlistCubit(
        getWishlistUsecase: sl(),
        addToWishlistUsecase: sl(),
        removeFromWishlistUsecase: sl(),
      ));

  // ==================== Orders ====================
  // Repository
  sl.registerLazySingleton<OrderRepository>(
    () => OrderRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetOrdersUsecase(sl()));
  sl.registerLazySingleton(() => GetOrderByIdUsecase(sl()));
  sl.registerLazySingleton(() => CreateOrderUsecase(sl()));
  sl.registerLazySingleton(() => CancelOrderUsecase(sl()));

  // Cubit
  sl.registerFactory(() => OrdersCubit(
        getOrdersUsecase: sl(),
        getOrderByIdUsecase: sl(),
        createOrderUsecase: sl(),
        cancelOrderUsecase: sl(),
      ));

  // ==================== Addresses ====================
  // Repository
  sl.registerLazySingleton<AddressRepository>(
    () => AddressRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetAddressesUsecase(sl()));
  sl.registerLazySingleton(() => AddAddressUsecase(sl()));
  sl.registerLazySingleton(() => UpdateAddressUsecase(sl()));
  sl.registerLazySingleton(() => DeleteAddressUsecase(sl()));

  // Cubit
  sl.registerFactory(() => AddressesCubit(
        getAddressesUsecase: sl(),
        addAddressUsecase: sl(),
        updateAddressUsecase: sl(),
        deleteAddressUsecase: sl(),
      ));

  // ==================== Reviews ====================
  // Repository
  sl.registerLazySingleton<ReviewRepository>(
    () => ReviewRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetProductReviewsUsecase(sl()));
  sl.registerLazySingleton(() => AddReviewUsecase(sl()));

  // Cubit
  sl.registerFactory(() => ReviewsCubit(
        getProductReviewsUsecase: sl(),
        addReviewUsecase: sl(),
      ));

  // ==================== Profile ====================
  // Repository
  sl.registerLazySingleton<ProfileRepository>(
    () => ProfileRepositoryImpl(supabaseService: sl()),
  );

  // Use Cases
  sl.registerLazySingleton(() => GetProfileUsecase(sl()));
  sl.registerLazySingleton(() => UpdateProfileUsecase(sl()));

  // Cubit
  sl.registerFactory(() => ProfileCubit(
        getProfileUsecase: sl(),
        updateProfileUsecase: sl(),
      ));

  // ==================== Chat ====================
  // Repository
  sl.registerLazySingleton<ChatRepository>(
    () => ChatRepositoryImpl(supabaseService: sl()),
  );

  // Cubit
  sl.registerFactory(() => ChatCubit(repository: sl()));

  // ==================== Notifications ====================
  // Repository
  sl.registerLazySingleton<NotificationRepository>(
    () => NotificationRepositoryImpl(supabaseService: sl()),
  );

  // Cubit
  sl.registerFactory(() => NotificationsCubit(repository: sl()));
}

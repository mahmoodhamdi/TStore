import 'package:dartz/dartz.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/supabase/supabase_tables.dart';
import 'package:t_store/features/cart/data/models/cart_item_model.dart';
import 'package:t_store/features/cart/domain/entities/cart_item_entity.dart';
import 'package:t_store/features/cart/domain/repositories/cart_repository.dart';

class CartRepositoryImpl implements CartRepository {
  final SupabaseService supabaseService;

  CartRepositoryImpl({required this.supabaseService});

  String get _userId => supabaseService.currentUser?.id ?? '';

  @override
  Future<Either<String, List<CartItemEntity>>> getCartItems() async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final response = await supabaseService.client
          .from(SupabaseTables.cartItems)
          .select('*, products(*, categories(name), brands(name))')
          .eq('user_id', _userId)
          .order('created_at', ascending: false);

      final items = (response as List)
          .map((json) => CartItemModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(items);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CartItemEntity>> addToCart({
    required String productId,
    required int quantity,
    Map<String, dynamic>? selectedAttributes,
  }) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      // Check if item already exists in cart
      final existing = await supabaseService.client
          .from(SupabaseTables.cartItems)
          .select()
          .eq('user_id', _userId)
          .eq('product_id', productId)
          .maybeSingle();

      if (existing != null) {
        // Update quantity
        final newQuantity = (existing['quantity'] as int) + quantity;
        final response = await supabaseService.client
            .from(SupabaseTables.cartItems)
            .update({'quantity': newQuantity})
            .eq('id', existing['id'])
            .select('*, products(*, categories(name), brands(name))')
            .single();

        return Right(CartItemModel.fromJson(response));
      }

      // Add new item
      final response = await supabaseService.client
          .from(SupabaseTables.cartItems)
          .insert({
            'user_id': _userId,
            'product_id': productId,
            'quantity': quantity,
            'selected_attributes': selectedAttributes,
          })
          .select('*, products(*, categories(name), brands(name))')
          .single();

      return Right(CartItemModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, CartItemEntity>> updateCartItem({
    required String cartItemId,
    required int quantity,
  }) async {
    try {
      if (quantity <= 0) {
        return await removeFromCart(cartItemId).then(
          (result) => result.fold(
            (error) => Left(error),
            (_) => const Left('تم إزالة المنتج من السلة'),
          ),
        );
      }

      final response = await supabaseService.client
          .from(SupabaseTables.cartItems)
          .update({'quantity': quantity})
          .eq('id', cartItemId)
          .select('*, products(*, categories(name), brands(name))')
          .single();

      return Right(CartItemModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> removeFromCart(String cartItemId) async {
    try {
      await supabaseService.client
          .from(SupabaseTables.cartItems)
          .delete()
          .eq('id', cartItemId);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> clearCart() async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      await supabaseService.client
          .from(SupabaseTables.cartItems)
          .delete()
          .eq('user_id', _userId);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Stream<List<CartItemEntity>> get cartStream {
    if (_userId.isEmpty) {
      return Stream.value([]);
    }

    return supabaseService.client
        .from(SupabaseTables.cartItems)
        .stream(primaryKey: ['id'])
        .eq('user_id', _userId)
        .asyncMap((data) async {
          // Fetch full data with products
          final result = await getCartItems();
          return result.fold(
            (_) => <CartItemEntity>[],
            (items) => items,
          );
        });
  }
}

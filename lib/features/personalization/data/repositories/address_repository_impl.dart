import 'package:dartz/dartz.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/supabase/supabase_tables.dart';
import 'package:t_store/features/personalization/data/models/address_model.dart';
import 'package:t_store/features/personalization/domain/entities/address_entity.dart';
import 'package:t_store/features/personalization/domain/repositories/address_repository.dart';

class AddressRepositoryImpl implements AddressRepository {
  final SupabaseService supabaseService;

  AddressRepositoryImpl({required this.supabaseService});

  String get _userId => supabaseService.currentUser?.id ?? '';

  @override
  Future<Either<String, List<AddressEntity>>> getAddresses() async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final response = await supabaseService.client
          .from(SupabaseTables.addresses)
          .select()
          .eq('user_id', _userId)
          .order('is_default', ascending: false)
          .order('created_at', ascending: false);

      final addresses = (response as List)
          .map((json) => AddressModel.fromJson(json as Map<String, dynamic>))
          .toList();

      return Right(addresses);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AddressEntity>> getAddressById(String id) async {
    try {
      final response = await supabaseService.client
          .from(SupabaseTables.addresses)
          .select()
          .eq('id', id)
          .single();

      return Right(AddressModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AddressEntity>> addAddress({
    required String fullName,
    required String phone,
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? state,
    String? postalCode,
    required String country,
    bool isDefault = false,
  }) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      // If this is default, unset other defaults
      if (isDefault) {
        await supabaseService.client
            .from(SupabaseTables.addresses)
            .update({'is_default': false})
            .eq('user_id', _userId);
      }

      final response = await supabaseService.client
          .from(SupabaseTables.addresses)
          .insert({
            'user_id': _userId,
            'full_name': fullName,
            'phone': phone,
            'address_line1': addressLine1,
            'address_line2': addressLine2,
            'city': city,
            'state': state,
            'postal_code': postalCode,
            'country': country,
            'is_default': isDefault,
          })
          .select()
          .single();

      return Right(AddressModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, AddressEntity>> updateAddress({
    required String id,
    required String fullName,
    required String phone,
    required String addressLine1,
    String? addressLine2,
    required String city,
    String? state,
    String? postalCode,
    required String country,
    bool isDefault = false,
  }) async {
    try {
      // If setting as default, unset other defaults
      if (isDefault) {
        await supabaseService.client
            .from(SupabaseTables.addresses)
            .update({'is_default': false})
            .eq('user_id', _userId);
      }

      final response = await supabaseService.client
          .from(SupabaseTables.addresses)
          .update({
            'full_name': fullName,
            'phone': phone,
            'address_line1': addressLine1,
            'address_line2': addressLine2,
            'city': city,
            'state': state,
            'postal_code': postalCode,
            'country': country,
            'is_default': isDefault,
          })
          .eq('id', id)
          .select()
          .single();

      return Right(AddressModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteAddress(String id) async {
    try {
      await supabaseService.client
          .from(SupabaseTables.addresses)
          .delete()
          .eq('id', id)
          .eq('user_id', _userId);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> setDefaultAddress(String id) async {
    try {
      // Unset other defaults
      await supabaseService.client
          .from(SupabaseTables.addresses)
          .update({'is_default': false})
          .eq('user_id', _userId);

      // Set new default
      await supabaseService.client
          .from(SupabaseTables.addresses)
          .update({'is_default': true})
          .eq('id', id);

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

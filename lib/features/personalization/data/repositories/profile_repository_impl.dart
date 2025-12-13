import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/supabase/supabase_tables.dart';
import 'package:t_store/features/auth/data/models/user_model.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';
import 'package:t_store/features/personalization/domain/repositories/profile_repository.dart';

class ProfileRepositoryImpl implements ProfileRepository {
  final SupabaseService supabaseService;

  ProfileRepositoryImpl({required this.supabaseService});

  String get _userId => supabaseService.currentUser?.id ?? '';

  @override
  Future<Either<String, UserEntity>> getProfile() async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final response = await supabaseService.client
          .from(SupabaseTables.profiles)
          .select()
          .eq('id', _userId)
          .maybeSingle();

      if (response == null) {
        // Create profile if not exists
        final user = supabaseService.currentUser!;
        final newProfile = await supabaseService.client
            .from(SupabaseTables.profiles)
            .insert({
              'id': _userId,
              'email': user.email,
              'full_name': user.userMetadata?['full_name'],
              'phone': user.userMetadata?['phone'],
            })
            .select()
            .single();
        return Right(UserModel.fromJson(newProfile));
      }

      return Right(UserModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, UserEntity>> updateProfile({
    String? fullName,
    String? phone,
  }) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final updateData = <String, dynamic>{};
      if (fullName != null) updateData['full_name'] = fullName;
      if (phone != null) updateData['phone'] = phone;

      if (updateData.isEmpty) {
        return getProfile();
      }

      final response = await supabaseService.client
          .from(SupabaseTables.profiles)
          .update(updateData)
          .eq('id', _userId)
          .select()
          .single();

      return Right(UserModel.fromJson(response));
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, String>> uploadAvatar(File imageFile) async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      final fileName = 'avatar_$_userId.${imageFile.path.split('.').last}';
      final bytes = await imageFile.readAsBytes();

      await supabaseService.client.storage
          .from('avatars')
          .uploadBinary(
            fileName,
            bytes,
            fileOptions: const FileOptions(
              cacheControl: '3600',
              upsert: true,
            ),
          );

      final avatarUrl = supabaseService.client.storage
          .from('avatars')
          .getPublicUrl(fileName);

      // Update profile with new avatar URL
      await supabaseService.client
          .from(SupabaseTables.profiles)
          .update({'avatar_url': avatarUrl})
          .eq('id', _userId);

      return Right(avatarUrl);
    } catch (e) {
      return Left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> deleteAvatar() async {
    try {
      if (_userId.isEmpty) {
        return const Left('يرجى تسجيل الدخول أولاً');
      }

      // Remove avatar URL from profile
      await supabaseService.client
          .from(SupabaseTables.profiles)
          .update({'avatar_url': null})
          .eq('id', _userId);

      // Try to delete file from storage
      try {
        await supabaseService.client.storage
            .from('avatars')
            .remove(['avatar_$_userId.jpg', 'avatar_$_userId.png']);
      } catch (_) {
        // Ignore storage errors
      }

      return const Right(null);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

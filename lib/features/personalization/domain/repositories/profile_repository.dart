import 'dart:io';
import 'package:dartz/dartz.dart';
import 'package:t_store/features/auth/domain/entities/user_entity.dart';

abstract class ProfileRepository {
  Future<Either<String, UserEntity>> getProfile();

  Future<Either<String, UserEntity>> updateProfile({
    String? fullName,
    String? phone,
  });

  Future<Either<String, String>> uploadAvatar(File imageFile);

  Future<Either<String, void>> deleteAvatar();
}

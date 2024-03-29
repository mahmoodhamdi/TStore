import 'package:t_store/features/personalization/data/models/user_model.dart';

abstract class UserRepo {
  Future<void> saveUserData(UserModel userModel);
  // Future<UserModel?> getUserData();
  Future<void> deleteUserData(String userId);
}

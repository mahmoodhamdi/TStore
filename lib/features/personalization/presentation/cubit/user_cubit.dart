import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/core/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';
import 'package:t_store/features/personalization/data/repositories/user_repo.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  final UserRepo _userRepo;

  UserCubit(this._userRepo) : super(UserInitial());

  Future<void> saveUserData(UserModel userModel) async {
    try {
      emit(UserSaving());
      await _userRepo.saveUserData(userModel);
      emit(UserSaved()); // Emit a state to indicate successful user data saving
    } on TFirebaseAuthException catch (e) {
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      emit(UserFailure(message: e.message));
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("platform exception: $e");
      }
      emit(UserFailure(message: e.message));
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("firebase exception: $e");
      }
      emit(UserFailure(message: e.message));
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("exceptions: $e");
      }
      emit(UserFailure(message: e.message));
    } catch (e) {
      emit(UserFailure(message: e.toString()));
    }
  }
}

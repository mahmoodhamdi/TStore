// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/core/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/core/utils/logging/logger.dart';
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
      TLoggerHelper.error("Firebase Auth Exception", e);
      emit(UserFailure(message: e.message));
    } on TPlatformException catch (e) {
      TLoggerHelper.error("Platform Exception", e);
      emit(UserFailure(message: e.message));
    } on TFirebaseException catch (e) {
      TLoggerHelper.error("Firebase Exception", e);
      emit(UserFailure(message: e.message));
    } on TExceptions catch (e) {
      TLoggerHelper.error("General Exception", e);
      emit(UserFailure(message: e.message));
    } catch (e, stackTrace) {
      TLoggerHelper.error("An error occurred", e);
      TLoggerHelper.error(stackTrace.toString());
      emit(UserFailure(message: e.toString()));
    }
  }
}

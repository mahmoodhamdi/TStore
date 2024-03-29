import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:t_store/core/utils/exceptions/exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:t_store/core/utils/exceptions/firebase_exceptions.dart';
import 'package:t_store/core/utils/exceptions/platform_exceptions.dart';
import 'package:t_store/features/personalization/data/models/user_model.dart';
import 'package:t_store/features/personalization/data/repositories/user_repo.dart';

class UserRepoImpl implements UserRepo {
  final CollectionReference _usersCollection =
      FirebaseFirestore.instance.collection('users');
  @override
  Future<void> saveUserData(UserModel userModel) async {
    try {
      await _usersCollection.doc(userModel.id).set(userModel.toJson());
    } on TPlatformException catch (e) {
      if (kDebugMode) {
        print("Platform exception: $e");
      }
      throw TPlatformException(e.code).message;
    } on FirebaseAuthException catch (e) {
      // Handle sign up with email exceptions
      if (kDebugMode) {
        print("firebase auth exception: $e");
      }
      throw TFirebaseAuthException(e.code).message;
    } on TFirebaseException catch (e) {
      if (kDebugMode) {
        print("Firebase exception: $e");
      }
      throw TFirebaseException(e.code).message;
    } on TExceptions catch (e) {
      if (kDebugMode) {
        print("Exceptions: $e");
      }
      throw TExceptions(e.message).message;
    }
  }

  @override
  Future<void> deleteUserData(String userId) async {
    
    await _usersCollection.doc(userId).delete();
  }
}

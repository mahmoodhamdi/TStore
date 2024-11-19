import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_store/core/utils/helpers/logger_helper.dart';
import 'package:t_store/core/utils/helpers/shared_preferences_exception_helper.dart';
import 'package:t_store/features/auth/data/models/login_response.dart';

abstract class AuthLocalDataSource {
  Future<void> cacheUserData(LoginUserData userData);
  Future<LoginUserData?> getCachedUserData();
  Future<void> clearUserData();
  Future<void> saveToken(String token);
  Future<String?> getToken();
  Future<bool> isLoggedIn();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final SharedPreferences sharedPreferences;

  // Storage Keys
  static const String userDataKey = 'CACHED_USER_DATA';
  static const String tokenKey = 'USER_TOKEN';
  static const String isLoggedInKey = 'IS_LOGGED_IN';

  AuthLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> cacheUserData(LoginUserData userData) async {
    try {
      final jsonString = json.encode(userData.toJson());
      LoggerHelper.info('Caching user data: $jsonString');

      await sharedPreferences.setString(userDataKey, jsonString);
      await sharedPreferences.setBool(isLoggedInKey, true);

      LoggerHelper.debug('User data cached successfully');
    } catch (e, stackTrace) {
      LoggerHelper.error(
        'Error caching user data  $e',
      );
      throw SharedPreferencesException(
        SharedPreferencesExceptionHelper.handleException(e),
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<LoginUserData?> getCachedUserData() async {
    try {
      LoggerHelper.debug('Retrieving cached user data');
      final jsonString = sharedPreferences.getString(userDataKey);

      if (jsonString != null) {
        LoggerHelper.info('Found cached user data: $jsonString');
        return LoginUserData.fromJson(json.decode(jsonString));
      }

      LoggerHelper.warning('No cached user data found');
      return null;
    } catch (e, stackTrace) {
      LoggerHelper.error(
        'Error retrieving cached user data  $e',
      );
      throw SharedPreferencesException(
        SharedPreferencesExceptionHelper.handleException(e),
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> clearUserData() async {
    try {
      LoggerHelper.info('Clearing user data');

      await sharedPreferences.remove(userDataKey);
      await sharedPreferences.remove(tokenKey);
      await sharedPreferences.setBool(isLoggedInKey, false);

      LoggerHelper.debug('User data cleared successfully');
    } catch (e, stackTrace) {
      LoggerHelper.error(
        'Error clearing user data $e',
      );
      throw SharedPreferencesException(
        SharedPreferencesExceptionHelper.handleException(e),
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<void> saveToken(String token) async {
    try {
      LoggerHelper.info('Saving user token');

      await sharedPreferences.setString(tokenKey, token);

      LoggerHelper.debug('Token saved successfully');
    } catch (e, stackTrace) {
      LoggerHelper.error(
        'Error saving token $e',
      );
      throw SharedPreferencesException(
        SharedPreferencesExceptionHelper.handleException(e),
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<String?> getToken() async {
    try {
      LoggerHelper.debug('Retrieving user token');
      final token = sharedPreferences.getString(tokenKey);

      if (token != null) {
        LoggerHelper.info('Token found');
      } else {
        LoggerHelper.warning('No token found');
      }

      return token;
    } catch (e, stackTrace) {
      LoggerHelper.error(
        'Error retrieving token $e',
      );
      throw SharedPreferencesException(
        SharedPreferencesExceptionHelper.handleException(e),
        error: e,
        stackTrace: stackTrace,
      );
    }
  }

  @override
  Future<bool> isLoggedIn() async {
    try {
      LoggerHelper.debug('Checking login status');
      final isLoggedIn = sharedPreferences.getBool(isLoggedInKey) ?? false;

      LoggerHelper.info('User login status: $isLoggedIn');
      return isLoggedIn;
    } catch (e, stackTrace) {
      LoggerHelper.error(
        'Error checking login status $e',
      );
      throw SharedPreferencesException(
        SharedPreferencesExceptionHelper.handleException(e),
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}

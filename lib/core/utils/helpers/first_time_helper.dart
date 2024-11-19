import 'package:shared_preferences/shared_preferences.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/utils/helpers/logger_helper.dart';
import 'package:t_store/core/utils/helpers/shared_preferences_exception_helper.dart';

class FirstTimeHelper {
  static const String isFirstTimeKEY = 'IS_FIRST_TIME';

  static Future<bool> isFirstTime() async {
    try {
      LoggerHelper.debug('Checking First Time Status');
      SharedPreferences sharedPreferences = sl<SharedPreferences>();
      final isFirstTime = sharedPreferences.getBool(isFirstTimeKEY) ?? false;

      LoggerHelper.info('User First Time status: $isFirstTime');
      return isFirstTime;
    } catch (e, stackTrace) {
      LoggerHelper.error(
        'Error checking First Time status $e',
      );
      throw SharedPreferencesException(
        SharedPreferencesExceptionHelper.handleException(e),
        error: e,
        stackTrace: stackTrace,
      );
    }
  }
}

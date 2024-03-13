import 'package:flutter/foundation.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:t_store/core/utils/helpers/helper_functions.dart';
import 'package:t_store/features/auth/presentation/views/login/login_view.dart';
import 'package:t_store/features/auth/presentation/views/on_boarding/on_boarding_view.dart';

class AuthenticationRepository extends GetxController {
  static AuthenticationRepository get instance => Get.find();
  final deviceStorage = GetStorage();
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  screenRedirect() async {
    if (kDebugMode) {
      print("IsFirstTime ${deviceStorage.read("isFirstTime")}");
    }
    deviceStorage.writeIfNull("isFirstTime", true);
    if (deviceStorage.read("isFirstTime") == true) {
      THelperFunctions.navigateReplacementToScreen(
          Get.context!, const OnBoardingView());
    } else {
      THelperFunctions.navigateReplacementToScreen(
          Get.context!, const LoginView());
    }
  }
}

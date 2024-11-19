import 'package:flutter/services.dart';
import 'package:t_store/core/utils/helpers/logger_helper.dart';

class PlatformExceptionHelper {
  static String handlePlatformError(PlatformException exception) {
    LoggerHelper.error("Platform Exception: ${exception.message}", exception);

    switch (exception.code) {
      case 'PERMISSION_DENIED':
        return "تم رفض الإذن. يرجى السماح للتطبيق بالوصول.";
      case 'PERMISSION_DENIED_NEVER_ASK':
        return "تم رفض الإذن نهائيًا. يمكنك تفعيل الإذن من الإعدادات.";
      case 'LOCATION_SERVICES_DISABLED':
        return "خدمات الموقع معطلة. يرجى تفعيل الموقع والمحاولة مرة أخرى.";
      case 'NETWORK_ERROR':
        return "خطأ في الشبكة. تأكد من اتصالك بالإنترنت.";
      case 'IO_ERROR':
        return "خطأ في الإدخال/الإخراج. حاول مرة أخرى لاحقًا.";
      case 'UNAVAILABLE':
        return "الخدمة غير متاحة حاليًا. حاول لاحقًا.";
      case 'ACTIVITY_NOT_FOUND':
        return "لا يمكن فتح التطبيق المطلوب. تأكد من وجوده.";
      case 'INVALID_ARGUMENT':
        return "تم تمرير بيانات غير صحيحة. يرجى التحقق والمحاولة مرة أخرى.";
      case 'TIMEOUT':
        return "انتهت المهلة. يرجى المحاولة مرة أخرى.";
      case 'SIGN_IN_FAILED':
        return "فشل تسجيل الدخول. تحقق من بياناتك وحاول مرة أخرى.";
      case 'USER_CANCELLED':
        return "تم إلغاء العملية من قبل المستخدم.";
      case 'STORAGE_FULL':
        return "الذاكرة ممتلئة. يرجى تحرير بعض المساحة والمحاولة مرة أخرى.";
      case 'INTERNAL_ERROR':
        return "حدث خطأ داخلي. حاول مرة أخرى لاحقًا.";
      case 'UNKNOWN_ERROR':
        return "خطأ غير معروف. حاول لاحقًا.";
      default:
        return "حدث خطأ غير متوقع: ${exception.code}. حاول مرة أخرى.";
    }
  }
}

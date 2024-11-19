import 'package:dio/dio.dart';

class DioExceptionHelper {
  static String handleDioError(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.connectionTimeout:
        return "انتهت مهلة الاتصال. يرجى التحقق من اتصالك بالإنترنت.";
      case DioExceptionType.sendTimeout:
        return "استغرق إرسال الطلب وقتًا طويلًا. تحقق من الإنترنت.";
      case DioExceptionType.receiveTimeout:
        return "الخادم استغرق وقتًا طويلًا للرد. حاول لاحقًا.";
      case DioExceptionType.badResponse:
        return _handleBadResponse(dioException.response);
      case DioExceptionType.cancel:
        return "تم إلغاء الطلب. حاول مرة أخرى.";
      case DioExceptionType.unknown:
        return dioException.message!.contains("SocketException")
            ? "يبدو أنك غير متصل بالإنترنت. تحقق من الاتصال."
            : "حدث خطأ غير متوقع. حاول مرة أخرى.";
      default:
        return "حدث خطأ غير متوقع. حاول مرة أخرى.";
    }
  }

  static String _handleBadResponse(Response? response) {
    if (response != null) {
      switch (response.statusCode) {
        case 400:
          return "طلب غير صحيح. تحقق من المدخلات.";
        case 401:
          return "غير مصرح. تأكد من بيانات الدخول.";
        case 403:
          return "تم رفض الوصول.";
        case 404:
          return "المورد غير موجود.";
        case 500:
          return "خطأ في الخادم. حاول لاحقًا.";
        case 503:
          return "الخدمة غير متاحة. حاول لاحقًا.";
        default:
          return "خطأ غير متوقع: ${response.statusCode}. حاول مرة أخرى.";
      }
    }
    return "حدث خطأ غير متوقع من الخادم. حاول لاحقًا.";
  }
}

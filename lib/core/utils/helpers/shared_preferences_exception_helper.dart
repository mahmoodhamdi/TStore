class SharedPreferencesException implements Exception {
  final String message;
  final dynamic error;
  final StackTrace? stackTrace;

  SharedPreferencesException(this.message, {this.error, this.stackTrace});

  @override
  String toString() => message;
}

class SharedPreferencesExceptionHelper {
  static String handleException(dynamic error) {
    if (error is FormatException) {
      return "خطأ في تنسيق البيانات المخزنة";
    } else if (error is TypeError) {
      return "خطأ في نوع البيانات المخزنة";
    } else {
      return "حدث خطأ غير متوقع أثناء الوصول للبيانات المحلية";
    }
  }
}

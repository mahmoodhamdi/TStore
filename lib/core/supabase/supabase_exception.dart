import 'package:supabase_flutter/supabase_flutter.dart';

/// Custom exception for Supabase errors
class SupabaseException implements Exception {
  final String message;
  final String? code;
  final dynamic originalError;

  SupabaseException({
    required this.message,
    this.code,
    this.originalError,
  });

  /// Create from AuthException
  factory SupabaseException.fromAuthException(AuthException e) {
    return SupabaseException(
      message: _getAuthErrorMessage(e.message),
      code: e.statusCode,
      originalError: e,
    );
  }

  /// Create from PostgrestException
  factory SupabaseException.fromPostgrestException(PostgrestException e) {
    return SupabaseException(
      message: _getDatabaseErrorMessage(e.message, e.code),
      code: e.code,
      originalError: e,
    );
  }

  /// Create from StorageException
  factory SupabaseException.fromStorageException(StorageException e) {
    return SupabaseException(
      message: _getStorageErrorMessage(e.message),
      code: e.statusCode,
      originalError: e,
    );
  }

  /// Create from generic exception
  factory SupabaseException.fromException(dynamic e) {
    if (e is AuthException) {
      return SupabaseException.fromAuthException(e);
    } else if (e is PostgrestException) {
      return SupabaseException.fromPostgrestException(e);
    } else if (e is StorageException) {
      return SupabaseException.fromStorageException(e);
    } else {
      return SupabaseException(
        message: e.toString(),
        originalError: e,
      );
    }
  }

  /// Get user-friendly auth error message
  static String _getAuthErrorMessage(String message) {
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('invalid login credentials')) {
      return 'البريد الإلكتروني أو كلمة المرور غير صحيحة';
    }
    if (lowerMessage.contains('email not confirmed')) {
      return 'يرجى تأكيد بريدك الإلكتروني أولاً';
    }
    if (lowerMessage.contains('user already registered')) {
      return 'هذا البريد الإلكتروني مسجل بالفعل';
    }
    if (lowerMessage.contains('password')) {
      return 'كلمة المرور يجب أن تكون 6 أحرف على الأقل';
    }
    if (lowerMessage.contains('email')) {
      return 'يرجى إدخال بريد إلكتروني صحيح';
    }
    if (lowerMessage.contains('rate limit')) {
      return 'تم تجاوز عدد المحاولات المسموحة. يرجى المحاولة لاحقاً';
    }
    if (lowerMessage.contains('network')) {
      return 'خطأ في الاتصال. يرجى التحقق من الإنترنت';
    }

    return message;
  }

  /// Get user-friendly database error message
  static String _getDatabaseErrorMessage(String message, String? code) {
    if (code == '23505') {
      return 'هذا العنصر موجود بالفعل';
    }
    if (code == '23503') {
      return 'لا يمكن حذف هذا العنصر لأنه مرتبط ببيانات أخرى';
    }
    if (code == 'PGRST116') {
      return 'العنصر غير موجود';
    }
    if (code == '42501') {
      return 'ليس لديك صلاحية للقيام بهذا الإجراء';
    }

    return message;
  }

  /// Get user-friendly storage error message
  static String _getStorageErrorMessage(String message) {
    final lowerMessage = message.toLowerCase();

    if (lowerMessage.contains('not found')) {
      return 'الملف غير موجود';
    }
    if (lowerMessage.contains('too large')) {
      return 'حجم الملف كبير جداً';
    }
    if (lowerMessage.contains('invalid')) {
      return 'نوع الملف غير مدعوم';
    }

    return message;
  }

  @override
  String toString() => 'SupabaseException: $message (code: $code)';
}

/// Extension to handle Supabase errors easily
extension SupabaseErrorHandler<T> on Future<T> {
  /// Handle Supabase errors and convert to SupabaseException
  Future<T> handleSupabaseError() async {
    try {
      return await this;
    } on AuthException catch (e) {
      throw SupabaseException.fromAuthException(e);
    } on PostgrestException catch (e) {
      throw SupabaseException.fromPostgrestException(e);
    } on StorageException catch (e) {
      throw SupabaseException.fromStorageException(e);
    } catch (e) {
      throw SupabaseException.fromException(e);
    }
  }
}

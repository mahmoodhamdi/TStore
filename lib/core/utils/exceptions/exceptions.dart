/// Exception class for handling various errors.
class TExceptions implements Exception {
  /// The associated error message.
  final String message;

  const TExceptions(
      [this.message = 'An unexpected error occurred. Please try again.']);

  factory TExceptions.fromCode(String code) {
    switch (code) {
      // Auth errors
      case 'email-already-in-use':
      case 'user_already_exists':
        return const TExceptions(
            'The email address is already registered. Please use a different email.');
      case 'invalid-email':
      case 'invalid_email':
        return const TExceptions(
            'The email address provided is invalid. Please enter a valid email.');
      case 'weak-password':
      case 'weak_password':
        return const TExceptions(
            'The password is too weak. Please choose a stronger password.');
      case 'user-disabled':
      case 'user_banned':
        return const TExceptions(
            'This user account has been disabled. Please contact support for assistance.');
      case 'user-not-found':
      case 'user_not_found':
        return const TExceptions('Invalid login details. User not found.');
      case 'wrong-password':
      case 'invalid_credentials':
        return const TExceptions(
            'Incorrect password. Please check your password and try again.');
      case 'INVALID_LOGIN_CREDENTIALS':
        return const TExceptions(
            'Invalid login credentials. Please double-check your information.');
      case 'too-many-requests':
      case 'over_request_rate_limit':
        return const TExceptions('Too many requests. Please try again later.');
      case 'invalid-argument':
        return const TExceptions(
            'Invalid argument provided to the authentication method.');
      case 'invalid-password':
        return const TExceptions('Incorrect password. Please try again.');
      case 'invalid-phone-number':
        return const TExceptions('The provided phone number is invalid.');
      case 'operation-not-allowed':
        return const TExceptions(
            'This operation is not allowed. Contact support for assistance.');
      case 'session-expired':
      case 'session_expired':
        return const TExceptions(
            'Your session has expired. Please sign in again.');
      case 'uid-already-exists':
        return const TExceptions(
            'The provided user ID is already in use by another user.');
      case 'sign_in_failed':
        return const TExceptions('Sign-in failed. Please try again.');
      case 'network-request-failed':
        return const TExceptions(
            'Network request failed. Please check your internet connection.');
      case 'internal-error':
        return const TExceptions('Internal error. Please try again later.');
      case 'invalid-verification-code':
      case 'otp_expired':
        return const TExceptions(
            'Invalid verification code. Please enter a valid code.');
      case 'invalid-verification-id':
        return const TExceptions(
            'Invalid verification ID. Please request a new verification code.');
      case 'quota-exceeded':
        return const TExceptions('Quota exceeded. Please try again later.');
      // Supabase specific errors
      case 'email_not_confirmed':
        return const TExceptions(
            'Please confirm your email address before signing in.');
      case 'phone_not_confirmed':
        return const TExceptions(
            'Please confirm your phone number before signing in.');
      case 'signup_disabled':
        return const TExceptions(
            'Sign up is currently disabled. Please try again later.');
      case 'email_provider_disabled':
        return const TExceptions(
            'Email sign-in is currently disabled. Please try another method.');
      case 'sms_send_failed':
        return const TExceptions(
            'Failed to send SMS. Please try again later.');
      default:
        return const TExceptions();
    }
  }

  factory TExceptions.fromApi(Map<String, dynamic> map) {
    {
      if (map.containsKey('message')) {
        return TExceptions(map['message']);
      }

      if (map.containsKey('error')) {
        return TExceptions(map['error']);
      }

      if (map.containsKey('error_description')) {
        return TExceptions(map['error_description']);
      }
    }
    return const TExceptions();
  }
}

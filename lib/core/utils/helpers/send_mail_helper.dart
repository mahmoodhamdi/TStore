import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'logger_helper.dart'; // Assuming LoggerHelper is in a separate file.

class SendMailHelper {
  final String username;
  final String password;
  final SmtpServer smtpServer;

  SendMailHelper({
    required this.username,
    required this.password,
  }) : smtpServer = gmail(username, password);

  // Method to send OTP email
  Future<void> sendOtpEmail(String recipientEmail, String otpCode) async {
    final message = Message()
      ..from = Address(username, 't_store App')
      ..recipients.add(recipientEmail)
      ..subject = 'Your OTP Code for t_store App'
      ..text = 'Your OTP code is: $otpCode' // Plain text version
      ..html =
          "<h1>Your OTP Code</h1>\n<p>Your OTP code is: <strong>$otpCode</strong></p>"; // HTML version

    try {
      final sendReport = await send(message, smtpServer);
      LoggerHelper.info(
          'OTP email sent to $recipientEmail. Send report: $sendReport');
    } on MailerException catch (e) {
      LoggerHelper.error('Failed to send OTP email to $recipientEmail.', e);
      for (var p in e.problems) {
        LoggerHelper.error('Problem: ${p.code}: ${p.msg}');
      }
    }
  }
}

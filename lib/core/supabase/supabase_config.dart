import 'package:flutter_dotenv/flutter_dotenv.dart';

/// Supabase Configuration
///
/// Uses environment variables from .env file for security
/// Never commit .env file to version control
class SupabaseConfig {
  /// Supabase Project URL
  static String get supabaseUrl =>
      dotenv.env['SUPABASE_URL'] ?? 'https://lskwrhujwhbxdefasppr.supabase.co';

  /// Supabase Anonymous Key (safe to expose in client)
  static String get supabaseAnonKey =>
      dotenv.env['SUPABASE_ANON_KEY'] ??
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imxza3dyaHVqd2hieGRlZmFzcHByIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NjU1ODA3MzIsImV4cCI6MjA4MTE1NjczMn0.1O_7OARrC4lSaFzyigEPes5Pn1j9s1aZE2l4ZwnSJCE';

  // Storage bucket names
  static const String productImagesBucket = 'product-images';
  static const String categoryImagesBucket = 'category-images';
  static const String brandLogosBucket = 'brand-logos';
  static const String bannerImagesBucket = 'banner-images';
  static const String avatarsBucket = 'avatars';
  static const String reviewImagesBucket = 'review-images';
}

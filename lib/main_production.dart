import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:t_store/core/supabase/supabase_service.dart';
import 'package:t_store/core/dependency_injection/service_locator.dart';
import 'package:t_store/core/utils/service_locator/service_locator.dart'
    as old_locator;
import 'package:t_store/t_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Load environment variables
  await dotenv.load(fileName: '.env');

  // Initialize Supabase
  await SupabaseService.initialize();

  // Setup dependency injection (new Supabase-based services)
  await setupServiceLocator();

  // Setup old service locator (for backward compatibility with shop features)
  old_locator.setupOldServiceLocator();

  runApp(const TStore());
}

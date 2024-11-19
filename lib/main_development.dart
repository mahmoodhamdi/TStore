import 'package:flutter/material.dart';
import 'package:t_store/core/depandancy_injection/service_locator.dart';
import 'package:t_store/core/utils/service_locator/service_locator.dart';
import 'package:t_store/t_store.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();

  await setupOldServiceLocator();

  runApp(const TStore());
}

import 'package:flutter/material.dart';
import 'package:t_store/core/utils/service_locator/service_locator.dart';
import 'package:t_store/t_store.dart';

void main() async {
  await setupServiceLocator();

  runApp(const TStore());
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/app.dart';
import 'package:student_clean_arch/core/network/local/hive_service.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  HiveService().init();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

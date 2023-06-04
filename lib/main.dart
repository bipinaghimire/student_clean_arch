import 'package:flutter/material.dart';
import 'package:student_clean_arch/features/ui/login.dart';
import 'package:student_clean_arch/features/ui/register.dart';

void main() {
  runApp(
    MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen()
      },
    ),
  );
}

import 'package:flutter/material.dart';
import 'package:student_clean_arch/features/auth/presentation/view/login.dart';
import 'package:student_clean_arch/features/auth/presentation/view/register.dart';
import 'package:student_clean_arch/features/batch/presentation/view/add_batch.dart';
import 'package:student_clean_arch/features/course/presentation/view/add_course.dart';
import 'package:student_clean_arch/features/home/presentation/view/bottom/dashboard.dart';
import 'package:student_clean_arch/features/home/presentation/view/bottom/profile.dart';
import 'package:student_clean_arch/features/home/presentation/view/home.dart';
import 'package:student_clean_arch/features/splash/presentation/view/splash_screen.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const HomeScreen(),
        '/addbatch': (context) => const AddBatchScreen(),
        '/addcourse': (context) => const AddCourseScreen(),
        '/dashboard': (context) => const DashboardScreen(),
        '/profile': (context) => const ProfileScreen(),
      },
    );
  }
}

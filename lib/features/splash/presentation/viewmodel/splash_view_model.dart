import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:student_clean_arch/core/shared_prefs/user_shared_pref.dart';

final splashViewModelProvider = ChangeNotifierProvider<SplashViewModel>((ref) {
  final userSharedPref = ref.watch(userSharedPrefsProvider);
  return SplashViewModel(userSharedPref: userSharedPref);
});

class SplashViewModel extends ChangeNotifier {
  final UserSharedPrefs userSharedPref;

  SplashViewModel({required this.userSharedPref});

  Future<bool> isUserLoggedIn(BuildContext context) async {
    final token = await userSharedPref.getUserToken();
    if (token != '') {
      Navigator.pushNamed(context, '/home');
      return true;
    } else {
      Navigator.pushNamed(context, '/login');
      return false;
    }
  }
}

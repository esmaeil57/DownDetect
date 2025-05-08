import 'dart:async';
import 'package:flutter/material.dart';
import '../views/login_screen.dart';
import '../views/main_navigation_screen.dart';

class SplashViewModel {
  Future<void> handleStartupLogic(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 2));

    // Placeholder: change to real logic later
    final bool isLoggedIn = false;

    if (isLoggedIn) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const MainNavigationScreen()),
      );
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(builder: (_) => const LoginScreen()),
      );
    }
  }
}

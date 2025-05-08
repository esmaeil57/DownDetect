import 'package:flutter/material.dart';
import '../view_model/splash_viewmodel.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final SplashViewModel splashViewModel = SplashViewModel();

  @override
  void initState() {
    super.initState();
    splashViewModel.handleStartupLogic(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0E6C73),
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF1BCCD9), Color(0xFF0E6C73)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            stops: [0.15, 0.78],
          ),
        ),
        child: Center(
          child: Image.asset(
            "images/logo_white-removebg-preview 2.png",
            width: 200,
          ),
        ),
      ),
    );
  }
}

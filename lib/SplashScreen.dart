import 'package:flutter/cupertino.dart';
import 'package:down_detect/sign%20in.dart';

class LodingScreen extends StatefulWidget {
  const LodingScreen({super.key});
  static const routeName='splash';
  @override
  State<LodingScreen> createState() => _LodingScreenState();
}

class _LodingScreenState extends State<LodingScreen> {
  @override
  void initState() {
    super.initState();
    navigateToHome();
  }

  @override
  Widget build(BuildContext context) {
    return  Container(
      width: double.infinity,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1BCCD9), // First color
            Color(0xFF0E6C73), // Second color
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [
            0.15, // Where the first color ends
            0.78, // Where the second color ends (or you can use 1.0 to continue to the bottom)
          ],
        ),


      ),
      child: Center(
        child: Image.asset("images/logo_white-removebg-preview 2.png"),

      ),
    );
  }

  void navigateToHome() {
    Future.delayed(
      const Duration(seconds: 3),
          () async {
        Navigator.pushReplacementNamed(context, LoginScreen.routeName);
      },
    );
  }
}
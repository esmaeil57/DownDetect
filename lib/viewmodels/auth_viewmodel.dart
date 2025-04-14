import 'package:flutter/material.dart';

class AuthViewModel extends ChangeNotifier {
  // Text field controllers
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  Future<void> signIn(BuildContext context) async {
    final email = emailController.text;
    final password = passwordController.text;

    _setLoading(true);

    await Future.delayed(const Duration(seconds: 2)); // Simulated network

    _setLoading(false);

    if (email.isNotEmpty && password.isNotEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );

    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter valid credentials")),
      );
    }
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }
}

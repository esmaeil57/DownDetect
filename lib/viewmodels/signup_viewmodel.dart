import 'package:flutter/material.dart';

class SignUpViewModel extends ChangeNotifier {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
  TextEditingController();

  String? selectedGender;

  void setGender(String? gender) {
    selectedGender = gender;
    notifyListeners();
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    selectedGender = null;
    notifyListeners();
  }

  Future<void> signUp(BuildContext context) async {
    debugPrint('Signing up: ${emailController.text}');
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Sign up simulated.")),
    );

    // Optional delay to simulate processing
    await Future.delayed(const Duration(milliseconds: 500));

    // ✅ Clear the form fields
    clearFields();
  }
}

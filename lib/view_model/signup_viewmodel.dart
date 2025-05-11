import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../data/services/user_service.dart';
import '../../core/network/api_client.dart'; // Import ApiClient if token needs to be set

class SignUpViewModel extends ChangeNotifier {
  final UserService _service = UserService();

  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  String? selectedRole; // Optional: 'admin' or 'customer'

  bool _isLoading = false;
  String? _errorMessage;

  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  void setRole(String? role) {
    selectedRole = role;
    notifyListeners();
  }

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  void clearFields() {
    nameController.clear();
    emailController.clear();
    passwordController.clear();
    confirmPasswordController.clear();
    selectedRole = null;
    notifyListeners();
  }

  Future<bool> signUp(BuildContext context) async {
    final name = nameController.text.trim();
    final email = emailController.text.trim();
    final password = passwordController.text;
    final confirmPassword = confirmPasswordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty ||
        confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill all fields")),
      );
      clearFields();
      return false; // ✅ Return false on error
    }

    if (password != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      clearFields();
      return false; // ✅ Return false on mismatch
    }

    final user = User(
      id: '',
      name: name,
      email: email,
      password: password,
      confirmPassword: confirmPassword,
      role: selectedRole?.toLowerCase() == 'admin' ? 'admin' : 'customer',
    );

    _setLoading(true);

    try {
      final result = await _service.register(user);

      final token = result['token'];
      if (token != null) {
        ApiClient.setAuthToken(token);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Registration successful")),
      );

      clearFields();
      return true; // ✅ Success
    } catch (e) {
      _errorMessage = 'Failed to Register';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!)),
      );
      print(e.toString());
      return false; // ✅ Catch failure
    } finally {
      _setLoading(false);
    }
  }}
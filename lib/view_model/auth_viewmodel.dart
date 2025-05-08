import 'package:flutter/material.dart';
import '../data/models/user_model.dart';
import '../../data/services/user_service.dart';

class AuthViewModel extends ChangeNotifier {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final UserService _service = UserService();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _isLoggedIn = false;
  bool get isLoggedIn => _isLoggedIn;

  User? _currentUser;
  String? _token;
  String? _errorMessage;

  User? get currentUser => _currentUser;
  String? get token => _token;
  String? get errorMessage => _errorMessage;
  bool get isAdmin => _currentUser?.role == 'admin';

  void _setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<bool> signIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    _setLoading(true);

    try {
      final result = await _service.login(email, password);
      _currentUser = result['user'];
      _token = result['token'];
      _isLoggedIn = true;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );

      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Login failed. Please check your credentials.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!)),
      );
      print(e.toString());
      return false;
    } finally {
      _setLoading(false);
    }
  }


  void logout() {
    _isLoggedIn = false;
    _currentUser = null;
    _token = null;
    emailController.clear();
    passwordController.clear();
    _service.logout();
    notifyListeners();
  }
}

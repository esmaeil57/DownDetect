import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
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

  void clearFields(){
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }


  Future<bool> signIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    _setLoading(true);

    try {
      final result = await _service.login(email, password);
      final token = result['token'];

      final decoded = JwtDecoder.decode(token);
      final role = decoded['role'] ?? 'customer';
      final userId = decoded['id'] ?? ''; // Adjust key name based on your JWT

      _currentUser = User(
        id: userId,
        name: '', // Optional: add if your token or backend gives it
        email: email,
        password: '',
        confirmPassword: '',
        role: role,
      );

      _token = token;
      _isLoggedIn = true;

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('token', token);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );

      clearFields();
      notifyListeners();
      return true;
    } catch (e) {
      _errorMessage = 'Login failed. Please check your credentials.';
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(_errorMessage!)),
      );
      clearFields();
      return false;
    } finally {
      _setLoading(false);
    }
  }



  void logout() async{
    _isLoggedIn = false;
    _currentUser = null;
    _token = null;
    emailController.clear();
    passwordController.clear();
    _service.logout();

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    notifyListeners();
  }
}

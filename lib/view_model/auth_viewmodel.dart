import 'package:flutter/material.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';
import '../data/models/user_model.dart';
import '../../data/services/user_service.dart';
import 'package:down_detect/view_model/profile_viewmodel.dart';

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

  void clearFields() {
    emailController.clear();
    passwordController.clear();
    notifyListeners();
  }

  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final savedToken = prefs.getString('token');

    if (savedToken != null && savedToken.isNotEmpty) {
      try {
        final decoded = JwtDecoder.decode(savedToken);
        final role = decoded['role'] ?? 'customer';
        final userId = decoded['id'] ?? '';
        final email = decoded['email'] ?? '';

        _currentUser = User(
          id: userId,
          name: '',
          email: email,
          password: '',
          confirmPassword: '',
          role: role,
        );
        _token = savedToken;
        _isLoggedIn = true;
        notifyListeners();
      } catch (e) {
        await prefs.remove('token'); // Remove corrupt/expired token
      }
    }
  }

  Future<bool> signIn(BuildContext context) async {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    _setLoading(true);

    try {
      // Log out first to ensure clean state if previously logged in
      await logout(context, showSnackbar: false);

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

      // Reset and reload the profile view model to refresh user data
      await _resetProfileViewModel(context);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Login successful")),
      );
      notifyListeners();
      clearFields();
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

  // Reset the profile view model on login/logout
  Future<void> _resetProfileViewModel(BuildContext context) async {
    try {
      // Get the ProfileViewModel instance
      final profileViewModel = Provider.of<ProfileViewModel>(context, listen: false);

      // Reset and initialize with new user data
      await profileViewModel.resetProfile();
      await profileViewModel.initialize();
    } catch (e) {
      print('Error resetting profile view model: ${e.toString()}');
    }
  }

  Future<void> logout(BuildContext context, {bool showSnackbar = true}) async {
    _isLoggedIn = false;
    _currentUser = null;
    _token = null;
    emailController.clear();
    passwordController.clear();
    await _service.logout();
    _errorMessage = null;

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('token');

    // Reset the profile view model when logging out
    await _resetProfileViewModel(context);

    if (showSnackbar) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Logged out successfully")),
      );
    }

    notifyListeners();
  }
}
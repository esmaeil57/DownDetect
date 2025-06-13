import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_client.dart';
import '../models/user_model.dart';

class UserService {
  // Constants for token keys to ensure consistency
  static const String AUTH_TOKEN_KEY = 'auth_token';
  static const String TOKEN_KEY = 'token';

  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await ApiClient.dio.post('/auth/login', data: {
      "email": email,
      "password": password,
    });

    final token = response.data['token'];
    if (token == null) throw Exception('Token missing in response');

    final prefs = await SharedPreferences.getInstance();
    // Store token in both keys for backward compatibility
    await prefs.setString(AUTH_TOKEN_KEY, token);
    await prefs.setString(TOKEN_KEY, token);

    ApiClient.setAuthToken(token);

    // If no user data is returned, use email and default values
    final user = User(
      id: '', // or decode from JWT if needed
      name: '',
      email: email,
      password: '',
      confirmPassword: '',
      role: 'customer',
    );

    return {'user': user, 'token': token};
  }

  Future<Map<String, dynamic>> register(User user) async {
    final response = await ApiClient.dio.post('/auth/register', data: user.toJson());

    final createdUser = User.fromJson(response.data['user']);
    final token = response.data['token']; // optional: if backend returns token

    if (token != null) {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(AUTH_TOKEN_KEY, token);
      await prefs.setString(TOKEN_KEY, token);
      ApiClient.setAuthToken(token);
    }

    return {'user': createdUser, 'token': token};
  }

  Future<String?> getUserRoleFromToken() async {
    final token = await getSavedToken();

    if (token != null) {
      final decodedToken = JwtDecoder.decode(token);
      return decodedToken['role']; // e.g., "admin" or "customer"
    }
    return null;
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    // Clear tokens from both keys
    await prefs.remove(AUTH_TOKEN_KEY);
    await prefs.remove(TOKEN_KEY);

    // Clear any profile image caches
    final token = await getSavedToken();
    if (token != null) {
      await prefs.remove('profile_image_$token');
    }

    ApiClient.clearAuthToken();
  }

  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    // Try both token keys for backward compatibility
    String? token = prefs.getString(AUTH_TOKEN_KEY);
    if (token == null) {
      token = prefs.getString(TOKEN_KEY);
    }
    return token;
  }

  Future<User> fetchProfile() async {
    final token = await getSavedToken();
    if (token == null) {
      throw Exception('No authentication token found');
    }

    ApiClient.setAuthToken(token); // ✅ VERY IMPORTANT

    try {
      final response = await ApiClient.dio.get('/users/');
      return User.fromJson(response.data['user']); // ✅ adjust for response format
    } catch (e) {
      throw Exception('Failed to fetch profile: ${e.toString()}');
    }
  }

  Future<Map<String, dynamic>?> getUserFromToken() async {
    final token = await getSavedToken();
    if (token == null) return null;

    try {
      final decodedToken = JwtDecoder.decode(token);
      return decodedToken;
    } catch (e) {
      print('Error decoding token: ${e.toString()}');
      return null;
    }
  }
}
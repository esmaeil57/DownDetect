import 'package:shared_preferences/shared_preferences.dart';
import '../../core/network/api_client.dart';
import '../models/user_model.dart';

class UserService {
  Future<Map<String, dynamic>> login(String email, String password) async {
    final response = await ApiClient.dio.post('/auth/login', data: {
      "email": email,
      "password": password,
    });

    final token = response.data['token'];
    if (token == null) throw Exception('Token missing in response');

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);

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
    return {'user': createdUser, 'token': token};
  }

  Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    ApiClient.clearAuthToken();
  }

  Future<String?> getSavedToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }
}

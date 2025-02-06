import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:next_step/services/student_service.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService extends GetxService {
  final StudentService _studentService = StudentService();
  String? _currentUserId;
  final _isLoggedIn = false.obs;
  static const String UUID_KEY = 'uuid';

  Future<AuthService> init() async {
    final userProfile = await getUserProfile();
    _isLoggedIn.value = userProfile != null;
    return this;
  }

  Future<UserDTO?> signIn(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('http://localhost:8080/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'username': username, 'password': password}),
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> userData = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('user', jsonEncode(userData));
        _isLoggedIn.value = true;
        _currentUserId = userData['id'];
        return UserDTO.fromJson(userData);
      } else {
        throw Exception('Failed to sign in: ${response.body}');
      }
    } catch (e) {
      _isLoggedIn.value = false;
      throw Exception('Failed to sign in: $e');
    }
  }

  Future<UserDTO?> getUserProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final userJson = prefs.getString('user');
      if (userJson != null) {
        final userData = jsonDecode(userJson);
        return UserDTO.fromJson(userData);
      }
      return null;
    } catch (e) {
      throw Exception('Failed to load user profile: $e');
    }
  }

  Future<String?> getCurrentUserId() async {
    if (_currentUserId != null) return _currentUserId;
    final prefs = await SharedPreferences.getInstance();
    final userJson = prefs.getString('user');
    if (userJson != null) {
      final userData = jsonDecode(userJson);
      _currentUserId = userData['id'];
    }
    return _currentUserId;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('user');
    _currentUserId = null;
    _isLoggedIn.value = false;
  }

  Future<void> refreshToken() async {
    throw UnimplementedError('refreshToken not implemented');
  }

  Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(UUID_KEY) != null;
  }

  Future<void> saveUUID(String uuid) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(UUID_KEY, uuid);
  }

  getUUID() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(UUID_KEY);
  }
}

class UserDTO {
  final String userId;
  final String username;
  final String email; // Add this
  final String telephone; // Add this

  UserDTO({
    required this.userId,
    required this.username,
    required this.email,
    required this.telephone,
  });

  factory UserDTO.fromJson(Map<String, dynamic> json) {
    return UserDTO(
      userId: json['id'],
      username: json['username'],
      email: json['email'] ?? '',
      telephone: json['telephone'] ?? '',
    );
  }
}

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:next_step/services/student_service.dart';

class AuthService extends GetxService {
  final StudentService _studentService = StudentService();
  String? _currentUserId;

  Future<String?> signIn(String username, String password) async {
    try {
      // Call the backend to authenticate the user
      final userId = await _studentService.authenticate(username, password);
      if (userId != null) {
        _currentUserId = userId;
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('userId', userId);
        return userId;
      }
    } catch (e) {
      throw Exception('Failed to sign in: $e');
    }
    return null;
  }

  Future<String?> getCurrentUserId() async {
    if (_currentUserId != null) return _currentUserId;
    final prefs = await SharedPreferences.getInstance();
    _currentUserId = prefs.getString('userId');
    return _currentUserId;
  }

  Future<void> signOut() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('userId');
    _currentUserId = null;
  }
}

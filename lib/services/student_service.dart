import 'dart:convert';
import 'package:http/http.dart' as http;

class StudentService {
  static const String _baseUrl = 'http://localhost:8080/users';

  Future<void> registerStudent({
    required String username,
    required String name,
    required String email,
    required String password,
    required String telephone,
    required String school,
    required String district,
  }) async {
    final uri = Uri.parse('$_baseUrl/students');
    final response = await http.post(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'name': name,
        'email': email,
        'password': password,
        'telephone': telephone,
        'role': 'STUDENT',
        'school': school,
        'district': district,
      }),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to register student: ${response.body}');
    }
  }

  Future<void> updateStudentProfile({
    required String studentId,
    required int educationLevel,
    required Map<String, double> olResults,
    required int alStream,
    required Map<String, double> alResults,
    required double gpa,
  }) async {
    final uri = Uri.parse('$_baseUrl/students/$studentId/profile');
    final response = await http.put(
      uri,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'educationLevel': educationLevel,
        'olResults': olResults,
        'alStream': alStream,
        'alResults': alResults,
        'gpa': gpa,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> getStudentProfile(String studentId) async {
    final uri = Uri.parse('$_baseUrl/students/$studentId/profile');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profile: ${response.body}');
    }
  }

  Future<List<dynamic>> getAllStudents() async {
    final uri = Uri.parse('$_baseUrl/students');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load students: ${response.body}');
    }
  }
}

import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/student_profile.dart';

class StudentService {
  static const String _baseUrl = 'http://localhost:8080/students';

  Future<String> registerStudent({
    required String username,
    required String name,
    required String email,
    required String password,
    required String telephone,
    required String school,
    required String district
  }) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'username': username,
        'name': name,
        'email': email,
        'password': password,
        'telephone': telephone,
        'role': 'STUDENT',
        'school': school,
        'district': district
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body)['id'];
    } else {
      throw Exception('Failed to register student: ${response.body}');
    }
  }

  Future<void> createStudent(Map<String, dynamic> studentData) async {
    final response = await http.post(
      Uri.parse('$_baseUrl/register'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(studentData),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to create student');
    }
  }

  Future<void> updateProfile(String studentId, StudentProfile profile) async {
    final response = await http.put(
      Uri.parse('$_baseUrl/profile'),
      headers: {'Content-Type': 'application/json', 'UUID': studentId},
      body: jsonEncode(profile.toJson()),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to update profile');
    }
  }

  Future<Map<String, dynamic>> getProfile(String studentId) async {
    final response = await http.get(
      Uri.parse('$_baseUrl/students/profile'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}

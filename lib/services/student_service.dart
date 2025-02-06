import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../models/student_profile.dart';

class StudentService extends GetxService {
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
      Uri.parse('$_baseUrl'),
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

  Future<Map<String, dynamic>> getProfile() async {
    final prefs = await SharedPreferences.getInstance();
    final uuid = prefs.getString('uuid');
    
    if (uuid == null) {
      throw Exception('No UUID found');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
        'UUID': uuid
      },
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load profile');
    }
  }
}

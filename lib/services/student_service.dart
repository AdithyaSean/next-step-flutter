import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/student_profile.dart';
import 'dart:convert';

class StudentService extends GetxService {
  static const String _baseUrl = 'http://localhost:8080/students';
  final _isInitialized = false.obs;

  @override
  void onInit() {
    super.onInit();
    initAsync(); // Don't await here, but start the initialization
  }

  @override
  void onReady() {
    super.onReady();
    // Additional setup after the widget is rendered if needed
  }

  Future<void> initAsync() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uuid = prefs.getString('uuid');
      if (uuid != null) {
        // Try to get the profile to verify the service is working
        await getProfile();
      }
      _isInitialized.value = true;
    } catch (e) {
      debugPrint('${Get.currentRoute} - StudentService initialization error: $e');
      _isInitialized.value = false;
    }
  }

  Future<String> registerStudent({
    required String username,
    required String name,
    required String email,
    required String password,
    required String telephone,
    required String school,
    required String district,
  }) async {
    debugPrint(
        '${Get.currentRoute} - registerStudent called with: username=$username, name=$name, email=$email, password=$password, telephone=$telephone, school=$school, district=$district');
    final response = await http.post(
      Uri.parse(_baseUrl),
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

    debugPrint('${Get.currentRoute} - registerStudent response status code: ${response.statusCode}');
    if (response.statusCode == 201) {
      final uuid = jsonDecode(response.body)['id'];
      debugPrint('${Get.currentRoute} - registerStudent successful, UUID: $uuid');
      return uuid;
    } else {
      debugPrint('${Get.currentRoute} - registerStudent failed: ${response.body}');
      throw Exception('Failed to register student: ${response.body}');
    }
  }

  Future<void> updateProfile(String studentId, StudentProfile profile) async {
    debugPrint('${Get.currentRoute} - updateProfile called with studentId: $studentId, profile: ${profile.toJson()}');
    final response = await http.put(
      Uri.parse('$_baseUrl/profile'),
      headers: {'Content-Type': 'application/json', 'UUID': studentId},
      body: jsonEncode(profile.toJson()),
    );

    debugPrint('${Get.currentRoute} - updateProfile response status code: ${response.statusCode}');
    if (response.statusCode != 200) {
      debugPrint('${Get.currentRoute} - Error updating profile: ${response.body}');
      throw Exception('Failed to update profile');
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    debugPrint('${Get.currentRoute} - getProfile called');
    final prefs = await SharedPreferences.getInstance();
    final uuid = prefs.getString('uuid');

    if (uuid == null) {
      debugPrint('${Get.currentRoute} - getProfile: No UUID found in SharedPreferences');
      throw Exception('No UUID found');
    }

    final response = await http.get(
      Uri.parse('$_baseUrl/profile'),
      headers: {
        'Content-Type': 'application/json',
        'UUID': uuid
      },
    );

    debugPrint('${Get.currentRoute} - getProfile response status code: ${response.statusCode}');
    if (response.statusCode == 200) {
      final profileData = jsonDecode(response.body);
      debugPrint('${Get.currentRoute} - getProfile successful: $profileData');
      return profileData;
    } else {
      debugPrint('${Get.currentRoute} - Error getting profile: ${response.body}');
      throw Exception('Failed to load profile');
    }
  }
}

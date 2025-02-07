import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import '../models/student_profile.dart';
import '../services/auth_service.dart';
import 'dart:convert';

class StudentService extends GetxService {
  static const String _baseUrl = 'http://localhost:8080';
  static const String _studentsEndpoint = '/students';
  final _isInitialized = false.obs;
  final _isServerAvailable = true.obs;

  bool get isServerAvailable => _isServerAvailable.value;

  String _handleConnectionError(dynamic error) {
    final errorStr = error.toString().toLowerCase();
    if (errorStr.contains('connection refused') || 
        errorStr.contains('failed to fetch') ||
        errorStr.contains('socket') ||
        errorStr.contains('cors')) {
      _isServerAvailable.value = false;
      return 'Unable to connect to server. Please ensure the server is running and accessible.';
    }
    return 'An unexpected error occurred. Please try again.';
  }

  @override
  void onInit() {
    super.onInit();
    initAsync(); // Don't await here, but start the initialization
  }

  Future<void> initAsync() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final uuid = prefs.getString(AuthService.uuidKey);
      if (uuid != null) {
        // Try to get the profile to verify the service is working
        await getProfile();
      }
      _isInitialized.value = true;
      _isServerAvailable.value = true;
    } catch (e) {
      debugPrint('${Get.currentRoute} - StudentService initialization error: ${_handleConnectionError(e)}');
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
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl$_studentsEndpoint'),
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
        _isServerAvailable.value = true;
        return uuid;
      } else {
        debugPrint('${Get.currentRoute} - registerStudent failed: ${response.body}');
        throw Exception('Failed to register student: ${response.body}');
      }
    } catch (e) {
      debugPrint('${Get.currentRoute} - registerStudent error: $e');
      throw Exception(_handleConnectionError(e));
    }
  }

  Future<void> updateProfile(String studentId, StudentProfile profile) async {
    debugPrint('${Get.currentRoute} - updateProfile called with studentId: $studentId, profile: ${profile.toJson()}');
    try {
      final response = await http.put(
        Uri.parse('$_baseUrl$_studentsEndpoint/profile'),
        headers: {'Content-Type': 'application/json', 'UUID': studentId},
        body: jsonEncode(profile.toJson()),
      );

      debugPrint('${Get.currentRoute} - updateProfile response status code: ${response.statusCode}');
      if (response.statusCode != 200) {
        debugPrint('${Get.currentRoute} - Error updating profile: ${response.body}');
        throw Exception('Failed to update profile');
      }
      _isServerAvailable.value = true;
    } catch (e) {
      debugPrint('${Get.currentRoute} - updateProfile error: $e');
      throw Exception(_handleConnectionError(e));
    }
  }

  Future<Map<String, dynamic>> getProfile() async {
    debugPrint('${Get.currentRoute} - getProfile called');
    try {
      final prefs = await SharedPreferences.getInstance();
      final uuid = prefs.getString(AuthService.uuidKey);

      if (uuid == null) {
        debugPrint('${Get.currentRoute} - getProfile: No UUID found in SharedPreferences');
        throw Exception('No UUID found');
      }

      final response = await http.get(
        Uri.parse('$_baseUrl$_studentsEndpoint/profile'),
        headers: {
          'Content-Type': 'application/json',
          'UUID': uuid
        },
      );

      debugPrint('${Get.currentRoute} - getProfile response status code: ${response.statusCode}');
      if (response.statusCode == 200) {
        final profileData = jsonDecode(response.body);
        debugPrint('${Get.currentRoute} - getProfile successful: $profileData');
        _isServerAvailable.value = true;
        return profileData;
      } else {
        debugPrint('${Get.currentRoute} - Error getting profile: ${response.body}');
        throw Exception('Failed to load profile');
      }
    } catch (e) {
      debugPrint('${Get.currentRoute} - getProfile error: $e');
      if (e.toString().contains('No UUID found')) {
        rethrow;
      }
      throw Exception(_handleConnectionError(e));
    }
  }
}

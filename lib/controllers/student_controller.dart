import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/services/auth_service.dart';
import '../services/student_service.dart';
import '../models/user.dart';
import '../models/student_profile.dart';

class StudentController extends GetxController {
  final StudentService _studentService = Get.find<StudentService>();
  final AuthService _authService = Get.find<AuthService>();
  final profile = Rxn<User>();
  final isLoading = false.obs;

  final RxString userId = ''.obs;
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ever(profile, (_) => update());
    loadUserInfo();
    loadProfile();
  }

  Future<StudentController> init() async {
    await loadUserInfo();
    await loadProfile();
    return this;
  }

  Future<void> loadProfile() async {
    debugPrint('${Get.currentRoute} - loadProfile called');
    try {
      isLoading.value = true;
      final uuid = await _authService.getCurrentUserId();
      debugPrint('${Get.currentRoute} - Loading profile for UUID: $uuid');

      if (uuid == null) {
        debugPrint('${Get.currentRoute} - No UUID found, clearing profile');
        profile.value = null;
        return;
      }

      // Get the user data from auth service first
      final authUser = await _authService.getUserProfile();
      if (authUser == null) {
        debugPrint('${Get.currentRoute} - No auth user found');
        profile.value = null;
        return;
      }

      // Get the student profile data
      final studentData = await _studentService.getProfile();
      debugPrint(
          '${Get.currentRoute} - Student profile data received: $studentData');

      // Merge the data
      profile.value = User(
        id: authUser.id,
        username: authUser.username,
        name: authUser.name,
        email: authUser.email,
        password: '',
        telephone: authUser.telephone,
        role: authUser.role,
        active: authUser.active,
        createdAt: DateTime.parse(
            studentData['createdAt'] ?? DateTime.now().toIso8601String()),
        updatedAt: DateTime.parse(
            studentData['updatedAt'] ?? DateTime.now().toIso8601String()),
        school: authUser.school,
        district: authUser.district,
        educationLevel: studentData['educationLevel'] ?? 0,
        olResults: Map<String, double>.from(studentData['olResults'] ?? {}),
        alStream: studentData['alStream'],
        alResults: Map<String, double>.from(studentData['alResults'] ?? {}),
        careerProbabilities:
            Map<String, double>.from(studentData['careerProbabilities'] ?? {}),
        gpa: studentData['gpa']?.toDouble() ?? 0.0,
      );

      debugPrint(
          '${Get.currentRoute} - Profile updated: ${profile.value?.toJson()}');
    } catch (e) {
      debugPrint('${Get.currentRoute} - Error loading profile: $e');
      profile.value = null;
    } finally {
      isLoading.value = false;
      debugPrint(
          '${Get.currentRoute} - loadProfile finished - isLoading.value: ${isLoading.value}');
    }
  }

  Future<void> loadUserInfo() async {
    debugPrint('${Get.currentRoute} - loadUserInfo called');
    try {
      final uuid = await _authService.getCurrentUserId();
      final userProfile = await _authService.getUserProfile();

      if (userProfile != null) {
        userId.value = uuid ?? '';
        userName.value = userProfile.username;
        userEmail.value = userProfile.email;
        debugPrint(
            '${Get.currentRoute} - User info loaded: id=$uuid, name=${userProfile.username}, email=${userProfile.email}');
      } else {
        debugPrint('${Get.currentRoute} - No user profile found');
      }
    } catch (e) {
      debugPrint('${Get.currentRoute} - Error loading user info: $e');
    }
  }

  Future<bool> updateProfile(User updatedProfile) async {
    debugPrint('${Get.currentRoute} - updateProfile called');
    try {
      isLoading.value = true;
      final uuid = await _authService.getCurrentUserId();
      if (uuid == null) throw Exception('User ID not found');

      final studentProfile = StudentProfile(
        educationLevel: updatedProfile.educationLevel,
        olResults: updatedProfile.olResults,
        alStream: updatedProfile.alStream,
        alResults: updatedProfile.alResults,
        careerProbabilities: updatedProfile.careerProbabilities,
        gpa: updatedProfile.gpa,
      );

      debugPrint(
          '${Get.currentRoute} - Updating profile: ${studentProfile.toJson()}');
      await _studentService.updateProfile(uuid, studentProfile);
      await loadProfile(); // Reload the profile after update

      Get.snackbar(
        'Success',
        'Profile updated successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      return true;
    } catch (e) {
      debugPrint('${Get.currentRoute} - Error updating profile: $e');
      Get.snackbar(
        'Error',
        'Failed to update profile',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}

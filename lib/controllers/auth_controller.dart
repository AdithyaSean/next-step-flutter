import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:next_step/models/user.dart';
import '../services/auth_service.dart';

class AuthController extends GetxController {
  final AuthService _authService = Get.find<AuthService>();
  final RxBool isLoading = false.obs;
  final RxBool isAuthenticated = false.obs;
  final Rxn<User?> currentUser = Rxn<User?>();
  bool _initialized = false;

  @override
  void onInit() {
    super.onInit();
    // Don't auto-initialize since we want to control the initialization flow
  }

  Future<void> initialize() async {
    if (_initialized) return;
    
    try {
      isLoading.value = true;
      await _authService.initAsync(); // Ensure service is initialized
      await checkAuthentication();
      _initialized = true;
    } catch (e) {
      debugPrint('${Get.currentRoute} - AuthController initialization error: $e');
      isAuthenticated.value = false;
      currentUser.value = null;
      // Redirect to login if initialization fails
      if (Get.currentRoute != '/login') {
        Get.offAllNamed('/login');
      }
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkAuthentication() async {
    debugPrint('${Get.currentRoute} - checkAuthentication called');
    isLoading.value = true;
    try {
      final isLoggedIn = await _authService.isLoggedIn();
      if (!isLoggedIn) {
        isAuthenticated.value = false;
        currentUser.value = null;
        debugPrint('${Get.currentRoute} - checkAuthentication: User not logged in');
        return;
      }

      debugPrint('${Get.currentRoute} - checkAuthentication isLoggedIn: $isLoggedIn');
      
      await loadUserProfile();
      
      // Only set authenticated if we successfully loaded the user profile
      if (currentUser.value != null) {
        isAuthenticated.value = true;
      } else {
        isAuthenticated.value = false;
        debugPrint('${Get.currentRoute} - checkAuthentication: User profile not loaded');
      }
    } catch (e) {
      debugPrint('${Get.currentRoute} - checkAuthentication error: $e');
      isAuthenticated.value = false;
      currentUser.value = null;
    } finally {
      isLoading.value = false;
    }
    debugPrint('${Get.currentRoute} - checkAuthentication finished - isAuthenticated: $isAuthenticated, currentUser: ${currentUser.value?.toJson()}');
  }

  Future<void> loadUserProfile() async {
    debugPrint('${Get.currentRoute} - loadUserProfile called');
    try {
      final userDTO = await _authService.getUserProfile();
      debugPrint('${Get.currentRoute} - loadUserProfile _authService.getUserProfile() called');
      debugPrint('${Get.currentRoute} - loadUserProfile userDTO from SharedPreferences: ${userDTO?.toJson()}');
      if (userDTO != null) {
        debugPrint('${Get.currentRoute} - loadUserProfile userDTO received: ${userDTO.toJson()}');
        currentUser.value = User(
          id: userDTO.id,
          username: userDTO.username,
          name: userDTO.name,
          email: userDTO.email,
          password: '',
          telephone: userDTO.telephone,
          role: userDTO.role,
          active: true,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          school: userDTO.school,
          district: userDTO.district,
          educationLevel: userDTO.educationLevel,
          olResults: userDTO.olResults,
          alStream: userDTO.alStream,
          alResults: userDTO.alResults,
          careerProbabilities: userDTO.careerProbabilities,
          gpa: userDTO.gpa,
        );
        debugPrint('${Get.currentRoute} - loadUserProfile successful: ${currentUser.value?.toJson()}');
      } else {
        debugPrint('${Get.currentRoute} - loadUserProfile: userDTO is null');
        currentUser.value = null;
      }
    } catch (e) {
      debugPrint('${Get.currentRoute} - loadUserProfile error: $e');
      isAuthenticated.value = false;
      currentUser.value = null;
      rethrow;
    }
    debugPrint('${Get.currentRoute} - loadUserProfile finished - currentUser.value: ${currentUser.value?.toJson()}');
  }

  Future<void> signOut() async {
    debugPrint('${Get.currentRoute} - signOut called');
    try {
      isLoading.value = true;
      await _authService.signOut();
      isAuthenticated.value = false;
      currentUser.value = null;
      Get.offAllNamed('/login');
    } catch (e) {
      debugPrint('${Get.currentRoute} - signOut error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshSession() async {
    debugPrint('${Get.currentRoute} - refreshSession called');
    try {
      isLoading.value = true;
      await _authService.refreshToken();
      await loadUserProfile();
    } catch (e) {
      isAuthenticated.value = false;
      currentUser.value = null;
      debugPrint('${Get.currentRoute} - refreshSession error: $e');
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}

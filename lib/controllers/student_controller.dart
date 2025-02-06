import 'package:get/get.dart';
import 'package:next_step/services/auth_service.dart';
import '../services/student_service.dart';
import '../models/student_profile.dart';

class StudentController extends GetxController {
  final StudentService _studentService = Get.find<StudentService>();
  final AuthService _authService = Get.find<AuthService>();
  final Rx<StudentProfile?> profile = Rx<StudentProfile?>(null);
  final RxBool isLoading = false.obs;

  // Add Rx variables for user info
  final RxString userId = ''.obs;
  final RxString userName = ''.obs;
  final RxString userEmail = ''.obs;

  @override
  void onInit() {
    super.onInit();
    ever(profile, (_) => update()); // Add reactive update
    loadUserInfo();
    loadProfile();
  }

  Future<void> loadProfile() async {
    try {
      isLoading.value = true;
      final data = await _studentService.getProfile();
      profile.value = StudentProfile.fromJson(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to load profile');
      profile.value = null;
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadUserInfo() async {
    try {
      final uuid = await _authService.getUUID();
      final userProfile = await _authService.getUserProfile();
      
      userId.value = uuid ?? '';
      userName.value = userProfile?.username ?? '';
      userEmail.value = userProfile?.email ?? '';
    } catch (e) {
      print('Error loading user info: $e');
    }
  }

  Future<void> updateProfile(StudentProfile updatedProfile) async {
    try {
      isLoading.value = true;
      final uuid = await _authService.getUUID();
      await _studentService.updateProfile(uuid!, updatedProfile);
      await loadProfile();
      Get.snackbar('Success', 'Profile updated successfully');
    } catch (e) {
      Get.snackbar('Error', 'Failed to update profile');
    } finally {
      isLoading.value = false;
    }
  }
}
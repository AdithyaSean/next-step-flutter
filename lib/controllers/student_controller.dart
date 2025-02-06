import 'package:get/get.dart';
import '../services/student_service.dart';
import '../models/student_profile.dart';

class StudentController extends GetxController {
  final StudentService _studentService = Get.find<StudentService>();
  final Rx<StudentProfile?> profile = Rx<StudentProfile?>(null);
  final RxBool isLoading = false.obs;

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
}
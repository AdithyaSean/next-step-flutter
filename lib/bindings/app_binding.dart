import 'package:get/get.dart';
import 'package:next_step/controllers/auth_controller.dart';
import 'package:next_step/controllers/student_controller.dart';
import 'package:next_step/services/auth_service.dart';
import 'package:next_step/services/student_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put<AuthService>(AuthService(), permanent: true);
    Get.put<StudentService>(StudentService(), permanent: true);
    Get.put<AuthController>(AuthController(), permanent: true);
    Get.put<StudentController>(StudentController(), permanent: true);
  }
}

import 'package:get/get.dart';
import '../services/auth_service.dart';
import '../services/student_service.dart';
import '../controllers/student_controller.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(AuthService(), permanent: true);
    Get.put(StudentService(), permanent: true);
    Get.put(StudentController(), permanent: true);
  }
}
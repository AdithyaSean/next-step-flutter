import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:next_step/controllers/auth_controller.dart';
import 'package:next_step/controllers/student_controller.dart';
import 'package:next_step/services/auth_service.dart';
import 'package:next_step/services/student_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Create and register HTTP client
    final client = http.Client();
    Get.put<http.Client>(client);

    // Create and register AuthService
    final authService = AuthService(client);
    Get.put<AuthService>(authService);

    // Initialize StudentService first since controllers depend on it
    final studentService = StudentService();
    Get.put<StudentService>(studentService);

    // Create and register AuthController
    final authController = AuthController(authService: authService);
    Get.put<AuthController>(authController);
    
    // Create and register StudentController
    final studentController = StudentController();
    Get.put<StudentController>(studentController);

    // Initialize controllers
    authController.initialize();
    studentController.init();
  }
}

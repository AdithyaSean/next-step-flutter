import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:next_step/controllers/auth_controller.dart';
import 'package:next_step/services/auth_service.dart';
import 'package:next_step/services/student_service.dart';

class AppBinding extends Bindings {
  @override
  void dependencies() {
    // Create and register HTTP client
    final client = http.Client();
    Get.put<http.Client>(client);

    // Create and register AuthService
    Get.lazyPut<AuthService>(() => AuthService(Get.find<http.Client>()));

    // Create and register AuthController
    Get.lazyPut<AuthController>(() => AuthController(authService: Get.find<AuthService>()));
    
    // Initialize StudentService
    Get.put<StudentService>(StudentService());
  }
}

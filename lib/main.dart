import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/controllers/auth_controller.dart';
import 'package:next_step/screens/lets_get_started.dart';
import 'package:next_step/screens/home_screen.dart';
import 'package:next_step/services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize services
  await Get.putAsync<AuthService>(() async => await AuthService().init());
  
  // Initialize controllers
  Get.put(AuthController());

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Next Step',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const AuthWrapper(),
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen()),
      ],
    );
  }
}

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController = Get.find();

    return Obx(() {
      if (authController.isAuthenticated.value) {
        return const HomeScreen();
      }
      return const NextStepStart();
    });
  }
}

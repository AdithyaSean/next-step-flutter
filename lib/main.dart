import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/bindings/app_binding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:next_step/middleware/route_guard.dart';
import 'package:next_step/widgets/loading_overlay.dart';
import 'package:next_step/controllers/auth_controller.dart';
import 'screens/sign_in.dart';
import 'screens/home.dart';
import 'screens/profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies first
  final binding = AppBinding();
  binding.dependencies();
  
  final prefs = await SharedPreferences.getInstance();
  final uuid = prefs.getString('uuid');

  // Wait for auth controller to initialize
  final authController = Get.find<AuthController>();
  await authController.initialize();

  runApp(MyApp(initialRoute: uuid != null ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      builder: (controller) => GetMaterialApp(
        initialRoute: initialRoute,
        getPages: [
          GetPage(
            name: '/login', 
            page: () => const ResponsiveSignIn(),
            middlewares: [RouteGuard()]
          ),
          GetPage(
            name: '/home', 
            page: () => LoadingOverlay(child: const HomeScreen()),
            middlewares: [AuthGuard()]
          ),
          GetPage(
            name: '/profile', 
            page: () => LoadingOverlay(child: const ProfileScreen()),
            middlewares: [AuthGuard()]
          ),
        ],
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        unknownRoute: GetPage(
          name: '/notfound',
          page: () => LoadingOverlay(child: const HomeScreen()),
          middlewares: [AuthGuard()],
        ),
      ),
    );
  }
}

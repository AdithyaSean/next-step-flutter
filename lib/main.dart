import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/bindings/app_binding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:next_step/middleware/route_guard.dart';
import 'package:next_step/widgets/loading_overlay.dart';
import 'package:next_step/controllers/auth_controller.dart';
import 'package:next_step/models/user.dart';
import 'screens/sign_in.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'screens/edit_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize dependencies first
  final binding = AppBinding();
  binding.dependencies();
  
  runApp(const MyApp(initialRoute: '/login'));
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
          GetPage(
            name: '/profile/edit',
            page: () => LoadingOverlay(
              child: GetBuilder<AuthController>(
                builder: (controller) => EditProfileScreen(
                  initialProfile: controller.currentUser ?? User.empty()
                ),
              ),
            ),
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

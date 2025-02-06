import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/bindings/app_binding.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/sign_in.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'services/auth_service.dart';
import 'services/student_service.dart';
import 'controllers/student_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  final prefs = await SharedPreferences.getInstance();
  final uuid = prefs.getString('uuid');

  runApp(MyApp(initialRoute: uuid != null ? '/home' : '/login'));
}

class MyApp extends StatelessWidget {
  final String initialRoute;

  const MyApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialRoute: initialRoute,
      initialBinding: AppBinding(),
      getPages: [
        GetPage(name: '/home', page: () => const HomeScreen()),
        GetPage(name: '/login', page: () => const ResponsiveSignIn()),
        GetPage(name: '/profile', page: () => const ProfileScreen()),
      ],
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

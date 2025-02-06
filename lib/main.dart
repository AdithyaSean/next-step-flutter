import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/sign_in.dart';
import 'screens/home.dart';
import 'screens/profile.dart';
import 'services/auth_service.dart';
import 'services/student_service.dart';
import 'controllers/student_controller.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  await Get.putAsync(() => AuthService().init());
  Get.put(StudentService());
  Get.put(StudentController());
  
  final prefs = await SharedPreferences.getInstance();
  final uuid = prefs.getString('uuid');

  runApp(GetMaterialApp(
    initialRoute: uuid != null ? '/home' : '/login',
    getPages: [
      GetPage(name: '/home', page: () => const HomeScreen()),
      GetPage(name: '/login', page: () => const ResponsiveSignIn()),
      GetPage(name: '/profile', page: () => const ProfileScreen()),
    ],
  ));
}

class MyApp extends StatelessWidget {
  final String? userId;

  const MyApp({super.key, this.userId});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Next Step',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: userId != null ? const HomeScreen() : ResponsiveSignIn(),
    );
  }
}

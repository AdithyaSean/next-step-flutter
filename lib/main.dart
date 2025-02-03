import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/sign_in.dart';
import 'screens/home.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Get.putAsync(() => AuthService().init());

  final authService = Get.find<AuthService>();
  final isLoggedIn = await authService.isLoggedIn();

  runApp(GetMaterialApp(
    home: isLoggedIn ? const HomeScreen() : ResponsiveSignIn(),
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

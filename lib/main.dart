import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'screens/sign_in.dart';
import 'screens/home.dart';
import 'services/auth_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  final userId = prefs.getString('userId');

  // Initialize services
  await Get.putAsync(() async => AuthService());

  runApp(MyApp(userId: userId));
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
      home: userId != null ? HomeScreen() : ResponsiveSignIn(),
    );
  }
}

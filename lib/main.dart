import 'package:flutter/material.dart';
import 'package:next_step/screens/lets_get_started.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'core/service_locator.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:next_step/screens/home.dart';
import 'package:flutter/foundation.dart';
// Import drift separately to avoid naming conflicts
import 'package:drift/drift.dart' hide Column;
import 'package:next_step/screens/sign_in.dart';  // Add this import

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Enable verbose logging in debug mode
  if (kDebugMode) {
    driftRuntimeOptions.debugPrint = (String message) => print(message);
  }
  
  // Initialize Firebase first
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  
  // Setup service locator and wait for completion
  await setupServiceLocator();
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Get Started',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ResponsiveSignIn(), // Change SignInScreen to ResponsiveSignIn
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          color: Colors.white,
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'images/next_step.png',
                width: 200,
              ),
              const SizedBox(height: 24),
              const CircularProgressIndicator(),
            ],
          ),
        ),
      ),
    );
  }
}
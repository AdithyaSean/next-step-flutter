import 'package:flutter/material.dart';
//import 'package:next_step/interest.dart';
//import 'package:next_step/lets_get_started.dart';
//import 'package:next_step/change_password.dart';
//import 'package:next_step/forgot_password.dart';
//import 'package:next_step/sign_in.dart';
import 'package:next_step/sign_up.dart';

void main() {
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
      home: const ResponsiveSignUp(), // Use the imported widget
    );
  }
}
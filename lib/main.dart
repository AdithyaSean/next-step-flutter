import 'package:flutter/material.dart';
import 'package:next_step/interest.dart';
import'package:next_step/lets_get_started.dart';

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
      home: const NextStepStart(), // Use the imported widget
    );
  }
}
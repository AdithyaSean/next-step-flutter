import 'package:flutter/material.dart';
//import 'package:next_step/interest.dart';
//import 'package:next_step/lets_get_started.dart';
//import 'package:next_step/change_password.dart';
//import 'package:next_step/forgot_password.dart';
//import 'package:next_step/sign_in.dart';
//import 'package:next_step/sign_up.dart';
//import 'package:next_step/settings_ui.dart';
//import 'package:next_step/set_change_password.dart';
//import 'package:next_step/nav_bar.dart';
//import 'package:next_step/set_language_selection.dart';
//import 'package:next_step/two_factor.dart';
import 'package:next_step/two_factor_mobile.dart';


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
      home: const TwoFactorAuthScreenMobile(), // Use the imported widget
    );
  }
}
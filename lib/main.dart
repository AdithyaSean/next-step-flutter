import 'package:flutter/material.dart';
import 'package:next_step/screens/addEducation.dart';
import 'package:next_step/screens/interest.dart';
import 'package:next_step/screens/lets_get_started.dart';
import 'package:next_step/screens/change_password.dart';
import 'package:next_step/screens/forgot_password.dart';
import 'package:next_step/screens/sign_in.dart';
import 'package:next_step/screens/sign_up.dart';
import 'package:next_step/screens/settings_Ui.dart';
import 'package:next_step/screens/set_change_password.dart';
import 'package:next_step/widgets/nav_bar.dart';
import 'package:next_step/screens/set_language_selection.dart';
import 'package:next_step/screens/two_factor.dart';
import 'package:next_step/screens/two_factor_mobile.dart';
import 'package:next_step/screens/two_factor_email.dart';
import 'package:next_step/screens/notifications.dart';
import 'package:next_step/screens/recommendation.dart';
import 'package:next_step/screens/profile.dart';
import 'package:next_step/screens/education.dart';
import 'package:next_step/screens/explore.dart';
import 'package:next_step/screens/goverment_uni.dart';
import 'package:next_step/screens/private_uni.dart';
import 'package:next_step/screens/courses.dart';
import 'package:next_step/screens/recommendation_on_interest.dart';
import 'package:next_step/screens/home.dart';


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
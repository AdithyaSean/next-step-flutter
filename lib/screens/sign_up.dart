import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/screens/sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../services/student_service.dart';
import '../services/auth_service.dart';
import 'home.dart';

class ResponsiveSignUp extends StatelessWidget {
  const ResponsiveSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController usernameController = TextEditingController();
    final TextEditingController nameController = TextEditingController();
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();
    final TextEditingController telephoneController = TextEditingController();
    final TextEditingController schoolController = TextEditingController();
    final TextEditingController districtController = TextEditingController();

    return Scaffold(
      body: LayoutBuilder(
        builder: (context, constraints) {
          double formWidth = constraints.maxWidth;
          if (constraints.maxWidth > 600) {
            formWidth = constraints.maxWidth * 0.5;
          }
          if (constraints.maxWidth > 1200) {
            formWidth = constraints.maxWidth * 0.3;
          }

          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: formWidth,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: telephoneController,
                      decoration: InputDecoration(
                        labelText: 'Telephone',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: schoolController,
                      decoration: InputDecoration(
                        labelText: 'School',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: districtController,
                      decoration: InputDecoration(
                        labelText: 'District',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        final studentService = Get.find<StudentService>();
                        final authService = Get.find<AuthService>();
                        try {
                          // First try to sign in to check if user exists
                          try {
                            await authService.signIn(
                              usernameController.text,
                              passwordController.text,
                            );
                            // If sign in succeeds, user already exists
                            Get.snackbar(
                              'Error',
                              'Username already exists. Please try a different username.',
                              backgroundColor: Colors.red[100],
                              duration: const Duration(seconds: 5),
                            );
                            return;
                          } catch (_) {
                            // Sign in failed which is expected for new user
                          }

                          // Proceed with registration
                          final uuid = await studentService.registerStudent(
                            username: usernameController.text,
                            name: nameController.text,
                            email: emailController.text,
                            password: passwordController.text,
                            telephone: telephoneController.text,
                            school: schoolController.text,
                            district: districtController.text,
                          );

                          // Save the UUID in SharedPreferences
                          final prefs = await SharedPreferences.getInstance();
                          await prefs.setString(AuthService.uuidKey, uuid);

                          // Now sign in with the new account
                          final user = await authService.signIn(
                            usernameController.text,
                            passwordController.text,
                          );

                          if (user != null) {
                            Get.offAll(() => const HomeScreen());
                          } else {
                            throw Exception('Failed to sign in after registration');
                          }
                        } catch (e) {
                          final error = e.toString().toLowerCase();
                          if (error.contains('duplicate') && error.contains('email')) {
                            Get.snackbar(
                              'Error',
                              'This email is already registered. Please use a different email or sign in.',
                              backgroundColor: Colors.red[100],
                              duration: const Duration(seconds: 5),
                            );
                          } else {
                            Get.snackbar(
                              'Error',
                              'Failed to sign up. Please try again.',
                              backgroundColor: Colors.red[100],
                              duration: const Duration(seconds: 3),
                            );
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Sign Up', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 24),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('or sign up with'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            Get.to(() => const ResponsiveSignIn());
                          },
                          child: const Text('Sign In',
                              style: TextStyle(color: Colors.blue)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

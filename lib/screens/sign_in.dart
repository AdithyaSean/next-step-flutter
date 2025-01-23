import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'home.dart';
import 'sign_up.dart';
import '../services/auth_service.dart';

class ResponsiveSignIn extends StatelessWidget {
  const ResponsiveSignIn({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold( // Add Scaffold to provide Material ancestor
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust the form width based on device size
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
                    if (constraints.maxWidth > 400)
                      Image.asset(
                        'images/password_image.png',
                        height: constraints.maxWidth > 1200 ? 200 : 150,
                      ),
                    const SizedBox(height: 32),
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    TextFormField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                        onPressed: () {},
                        child: const Text('Forgot Password?', style: TextStyle(color: Colors.blue)),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () async {
                        // TODO: Implement email/password sign in
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Email/password sign in not implemented yet')),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Sign In', style: TextStyle(color: Colors.white)),
                    ),
                    const SizedBox(height: 24),
                    const Row(
                      children: [
                        Expanded(child: Divider()),
                        Padding(
                          padding: EdgeInsets.symmetric(horizontal: 16),
                          child: Text('or sign in with'),
                        ),
                        Expanded(child: Divider()),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          onPressed: () async {
                            try {
                              final authService = Get.find<AuthService>();
                              final user = await authService.signInWithGoogle();
                              if (user != null) {
                                Navigator.pushReplacement(context,
                                    MaterialPageRoute(builder: (context) => const HomeScreen()));
                              }
                            } catch (e) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text('Google sign in failed: ${e.toString()}')),
                              );
                            }
                          },
                          icon: Image.asset('images/google.png', width: 30, height: 30),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          onPressed: () {},
                          icon: Image.asset('images/facebook.png', width: 35, height: 35),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Don't have an account?"),
                        TextButton(
                          onPressed: () {
                            // Navigate to sign up screen
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => const ResponsiveSignUp()));
                          },
                          child: const Text('Sign up', style: TextStyle(color: Colors.blue)),
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

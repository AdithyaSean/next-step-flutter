import 'package:flutter/material.dart';
import 'package:next_step/screens/home.dart';
import 'package:next_step/screens/sign_up.dart';
import 'package:next_step/screens/profile_edit.dart';
import '../core/service_locator.dart';
import '../controllers/auth_controller.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Add this import

class ResponsiveSignIn extends StatefulWidget {
  const ResponsiveSignIn({super.key});

  @override
  State<ResponsiveSignIn> createState() => _ResponsiveSignInState();
}

class _ResponsiveSignInState extends State<ResponsiveSignIn> {
  late final AuthController _authController;
  bool _isLoading = false;
  final TextEditingController emailController = TextEditingController(); // Add this
  final TextEditingController passwordController = TextEditingController(); // Add this

  @override
  void initState() {
    super.initState();
    _authController = locator<AuthController>();
  }

  @override
  void dispose() {
    emailController.dispose(); // Dispose controllers
    passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignInSuccess(String userId) async {
    if (!mounted) return;

    final isComplete = await _authController.isProfileComplete(userId);
    
    if (!isComplete) {
      // Profile not complete, go to profile edit
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => ProfileEditScreen(studentId: userId),
        ),
      );
    } else {
      // Profile complete, go to home
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomeScreen(studentId: userId)), // Pass user ID after authentication
      );
    }
  }

  Widget _buildGoogleSignInButton() {
    return IconButton(
      onPressed: _isLoading ? null : () async {
        setState(() => _isLoading = true);
        try {
          final userId = await _authController.signInWithGoogle();
          if (!mounted) return;
          
          final isComplete = await _authController.isProfileComplete(userId);
          if (!isComplete) {
            // Profile not complete, go to profile edit
            if (!mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditScreen(studentId: userId),
              ),
            );
          } else {
            // Profile complete, go to home
            if (!mounted) return;
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen(studentId: userId)), // Pass user ID after authentication
            );
          }
        } catch (e) {
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: $e')),
          );
        } finally {
          if (mounted) setState(() => _isLoading = false);
        }
      },
      icon: _isLoading
          ? const SizedBox(
              width: 30,
              height: 30,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Image.asset('images/google.png', width: 30, height: 30),
    );
  }

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
                        try {
                          final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                            email: emailController.text,
                            password: passwordController.text,
                          );
                          if (!mounted) return;
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(studentId: userCredential.user!.uid),
                            ),
                          );
                        } catch (e) {
                          // Handle errors
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Error: $e')),
                          );
                        }
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
                        _buildGoogleSignInButton(),
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
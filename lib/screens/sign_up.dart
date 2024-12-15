import 'package:flutter/material.dart';
import '../data/models/student.dart' as model; // Import your Student model
import '../data/repositories/student_repository.dart'; // Import your StudentRepository
import '../data/database/database.dart'; // Import your database
import '../../services/firebase_db_service.dart'; // Import your Firebase service

class ResponsiveSignUp extends StatefulWidget {
  const ResponsiveSignUp({Key? key}) : super(key: key);

  @override
  _ResponsiveSignUpState createState() => _ResponsiveSignUpState();
}

class _ResponsiveSignUpState extends State<ResponsiveSignUp> {
  final List<String> districts = [
    'Ampara',
    'Anuradhapura',
    'Badulla',
    'Batticaloa',
    'Colombo',
    'Galle',
    'Gampaha',
    'Hambantota',
    'Jaffna',
    'Kalutara',
    'Kandy',
    'Kegalle',
    'Kilinochchi',
    'Kurunegala',
    'Mannar',
    'Matale',
    'Matara',
    'Monaragala',
    'Mullaitivu',
    'Nuwara Eliya',
    'Polonnaruwa',
    'Puttalam',
    'Ratnapura',
    'Trincomalee',
    'Vavuniya'
  ];

  String? selectedDistrict;
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController telephoneController = TextEditingController();
  final TextEditingController schoolController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Initialize your database and repository
  final StudentRepository studentRepository =
      StudentRepository(AppDatabase.instance, FirebaseDBService());

  @override
  Widget build(BuildContext context) {
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
                    if (constraints.maxWidth > 400)
                      Image.asset(
                        'images/signup.png',
                        height: constraints.maxWidth > 1200 ? 200 : 150,
                      ),
                    const SizedBox(height: 32),
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
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
                        labelText: 'E-mail',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      keyboardType: TextInputType.emailAddress,
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
                      keyboardType: TextInputType.phone,
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
                    DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        labelText: 'District',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      value: selectedDistrict,
                      items: districts.map((String district) {
                        return DropdownMenuItem<String>(
                          value: district,
                          child: Text(district),
                        );
                      }).toList(),
                      onChanged: (newValue) {
                        setState(() {
                          selectedDistrict = newValue;
                        });
                      },
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
                      controller: confirmPasswordController,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: 'Confirm Password',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: _signUp, // Call the sign-up method
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text('Sign Up',
                          style: TextStyle(color: Colors.white)),
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
                        IconButton(
                          onPressed: () {}, // Add Google sign-up logic
                          icon: Image.asset('images/google.png',
                              width: 30, height: 30),
                        ),
                        const SizedBox(width: 16),
                        IconButton(
                          onPressed: () {}, // Add Facebook sign-up logic
                          icon: Image.asset('images/facebook.png',
                              width: 35, height: 35),
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account?"),
                        TextButton(
                          onPressed: () {
                            // Navigate to sign in screen
                            Navigator.pop(context);
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

  void _signUp() async {
    if (passwordController.text == confirmPasswordController.text) {
      // Create a new Student object
      model.Student newStudent = model.Student(
        id: usernameController.text, // Assuming username is used as ID
        name: nameController.text,
        email: emailController.text,
        contact: telephoneController.text,
        school: schoolController.text,
        district: selectedDistrict ?? '',
        password: passwordController.text,
        olResults: {}, // Add appropriate data
        alResults: {}, // Add appropriate data
        stream: '', // Provide a default or user input for stream
        zScore: 0.0, // Provide a default value or user input for zScore
        interests: [], // Provide a default or user input for interests
        skills: [], // Provide a default or user input for skills
        strengths: [], // Provide a default or user input for strengths
        predictions: [], // Provide a default or user input for predictions
      );

      // Call the repository to create the student
      await studentRepository.createStudent(newStudent);
      // Show success message or navigate to another screen
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Sign Up Successful!')));
    } else {
      // Show error message
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Passwords do not match!')));
    }
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/controllers/student_controller.dart';
import 'package:next_step/models/student_profile.dart';
import 'package:next_step/screens/home.dart';
import 'package:next_step/services/auth_service.dart';
import 'package:next_step/services/student_service.dart';

class EditProfileScreen extends StatefulWidget {
  final StudentProfile initialProfile;

  const EditProfileScreen({super.key, required this.initialProfile});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late StudentProfile _profile;
  final StudentService _studentService = StudentService();

  @override
  void initState() {
    super.initState();
    _profile = widget.initialProfile;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveProfile,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEducationLevelField(),
              const SizedBox(height: 16),
              _buildOLResultsFields(),
              const SizedBox(height: 16),
              _buildALStreamField(),
              const SizedBox(height: 16),
              _buildALResultsFields(),
              const SizedBox(height: 16),
              _buildGPAField(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Education Information',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        _buildEducationLevelField(),
        const SizedBox(height: 8),
        _buildGPAField(),
      ],
    );
  }

  Widget _buildEducationLevelField() {
    return DropdownButtonFormField<int>(
      value: _profile.educationLevel,
      decoration: const InputDecoration(
        labelText: 'Education Level',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 1, child: Text('O/L')),
        DropdownMenuItem(value: 2, child: Text('A/L')),
      ],
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _profile.educationLevel = value;
          });
        }
      },
      validator: (value) {
        if (value == null) {
          return 'Please select education level';
        }
        return null;
      },
    );
  }

  Widget _buildOLResultsFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'O/L Results',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ..._profile.olResults.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextFormField(
              initialValue: entry.value.toString(),
              decoration: InputDecoration(
                labelText: entry.key,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _profile.olResults[entry.key] = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildALStreamField() {
    if (_profile.educationLevel < 2) {
      return const SizedBox.shrink();
    }
    
    return DropdownButtonFormField<int>(
      value: _profile.alStream ?? 1,
      decoration: const InputDecoration(
        labelText: 'A/L Stream',
        border: OutlineInputBorder(),
      ),
      items: const [
        DropdownMenuItem(value: 1, child: Text('Science')),
        DropdownMenuItem(value: 2, child: Text('Commerce')),
        DropdownMenuItem(value: 3, child: Text('Arts')),
      ],
      onChanged: (value) {
        if (value != null) {
          setState(() {
            _profile.alStream = value;
          });
        }
      },
    );
  }

  Widget _buildALResultsFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'A/L Results',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        ..._profile.alResults.entries.map((entry) {
          return Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextFormField(
              initialValue: entry.value.toString(),
              decoration: InputDecoration(
                labelText: entry.key,
                border: const OutlineInputBorder(),
              ),
              keyboardType: TextInputType.number,
              onChanged: (value) {
                setState(() {
                  _profile.alResults[entry.key] = double.tryParse(value) ?? 0.0;
                });
              },
            ),
          );
        }),
      ],
    );
  }

  Widget _buildGPAField() {
    return TextFormField(
      initialValue: _profile.gpa.toString(),
      decoration: const InputDecoration(
        labelText: 'GPA',
        border: OutlineInputBorder(),
      ),
      keyboardType: TextInputType.number,
      onChanged: (value) {
        setState(() {
          _profile.gpa = double.tryParse(value) ?? 0.0;
        });
      },
    );
  }

  Future<void> _saveProfile() async {
    if (_formKey.currentState!.validate()) {
      try {
        final authService = Get.find<AuthService>();
        final uuid = await authService.getUUID();
        
        await _studentService.updateProfile(uuid!, _profile);
        
        // Refresh profile data in controller
        final studentController = Get.find<StudentController>();
        await studentController.loadProfile();
        
        // Navigate to home screen after first-time profile completion
        Get.offAll(() => const HomeScreen());
      } catch (e) {
        Get.snackbar(
          'Error',
          'Failed to update profile: $e',
          snackPosition: SnackPosition.BOTTOM,
        );
      }
    }
  }
}

import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';
import 'package:next_step/models/student_profile.dart';
import 'package:next_step/screens/edit_profile.dart';
import 'package:get/get.dart';
import '../controllers/student_controller.dart';
import '../services/auth_service.dart';
import 'sign_in.dart';

class ProfileScreen extends GetView<StudentController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Profile')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile.value;
        if (profile == null) {
          return const Center(child: Text('No profile data'));
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildEducationSection(profile),
              _buildResultsSection('O/L Results', profile.olResults),
              if (profile.alStream != null)
                _buildResultsSection('A/L Results', profile.alResults),
              _buildCareerSection(profile.careerProbabilities),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildEducationSection(StudentProfile profile) {
    return Card(
      child: ListTile(
        title: Text('Education Level'),
        subtitle: Text('Level ${profile.educationLevel}'),
        trailing: Text('GPA: ${profile.gpa.toStringAsFixed(2)}'),
      ),
    );
  }

  Widget _buildResultsSection(String title, Map<String, double> results) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...results.entries.map((e) => 
          ListTile(
            title: Text(e.key),
            trailing: Text(e.value.toStringAsFixed(2)),
          )
        ),
      ],
    );
  }

  Widget _buildCareerSection(Map<String, double> probabilities) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Career Probabilities', 
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        ...probabilities.entries.map((e) => 
          ListTile(
            title: Text(e.key),
            trailing: Text('${(e.value * 100).toStringAsFixed(1)}%'),
          )
        ),
      ],
    );
  }
}

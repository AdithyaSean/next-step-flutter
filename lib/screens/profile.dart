import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';
import 'package:next_step/models/student_profile.dart';
import 'package:next_step/screens/edit_profile.dart';
import 'package:get/get.dart';
import '../controllers/student_controller.dart';

class ProfileScreen extends GetView<StudentController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              if (controller.profile.value != null) {
                Get.to(() => EditProfileScreen(
                  initialProfile: controller.profile.value!,
                ));
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final profile = controller.profile.value;
        if (profile == null) {
          return Center(
            child: ElevatedButton(
              onPressed: () {
                final userId = controller.userId.value;
                if (userId.isNotEmpty) {
                  Get.to(() => EditProfileScreen(
                    initialProfile: StudentProfile(id: userId),
                  ));
                } else {
                  Get.snackbar('Error', 'User ID not found');
                }
              },
              child: const Text('Create Profile'),
            ),
          );
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildProfileHeader(),
              _buildEducationSection(profile),
              _buildResultsSection('O/L Results', profile.olResults),
              if (profile.alStream != null)
                _buildResultsSection('A/L Results', profile.alResults),
              _buildCareerSection(profile.careerProbabilities),
            ],
          ),
        );
      }),
      bottomNavigationBar: const BottomNavContainer(selectedIndex: 3),
    );
  }

  Widget _buildProfileHeader() {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/images/profile.png'),
            ),
            const SizedBox(height: 16),
            Obx(() => Text(
              controller.userName.value.isEmpty 
                ? 'Student' 
                : controller.userName.value,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            )),
            const SizedBox(height: 8),
            Obx(() => Text(controller.userEmail.value)),
          ],
        ),
      ),
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

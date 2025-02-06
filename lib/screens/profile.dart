import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/controllers/auth_controller.dart';
import 'package:next_step/controllers/student_controller.dart';
import 'package:next_step/screens/edit_profile.dart';
import 'package:next_step/models/user.dart';

class ProfileScreen extends GetView<StudentController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              final mergedProfile = _getMergedProfile();
              Get.to(() => EditProfileScreen(initialProfile: mergedProfile));
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              authController.signOut();
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final authUser = authController.currentUser.value;
        final studentProfile = controller.profile.value;

        if (authUser == null && studentProfile == null) {
          return const Center(child: Text('No profile data available'));
        }

        final mergedProfile = _getMergedProfile();
        debugPrint('Displaying profile: ${mergedProfile.toJson()}');

        return SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: CircleAvatar(
                    radius: 60,
                    backgroundImage: const AssetImage('images/profile.png'),
                  ),
                ),
                const SizedBox(height: 20),
                // Personal Details Section
                const Text(
                  'Personal Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildProfileDetail('Name', mergedProfile.name),
                _buildProfileDetail('Username', mergedProfile.username),
                _buildProfileDetail('Email', mergedProfile.email),
                _buildProfileDetail('Telephone', mergedProfile.telephone),
                _buildProfileDetail('School', mergedProfile.school ?? 'N/A'),
                _buildProfileDetail('District', mergedProfile.district ?? 'N/A'),
                
                const SizedBox(height: 20),
                // Academic Details Section
                const Text(
                  'Academic Details',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                _buildProfileDetail('Education Level', getEducationLevelText(mergedProfile.educationLevel)),

                if (mergedProfile.olResults.isNotEmpty) ...[
                  const SizedBox(height: 10),
                  _buildResultsDetail('O/L Results', mergedProfile.olResults),
                ],

                if (mergedProfile.educationLevel >= 1) ...[
                  const SizedBox(height: 10),
                  _buildProfileDetail('A/L Stream', getALStreamText(mergedProfile.alStream)),
                  if (mergedProfile.alResults.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    _buildResultsDetail('A/L Results', mergedProfile.alResults),
                  ],
                ],

                if (mergedProfile.educationLevel == 2) ...[
                  const SizedBox(height: 10),
                  _buildProfileDetail('GPA', mergedProfile.gpa.toString()),
                ],

                if (mergedProfile.careerProbabilities.isNotEmpty) ...[
                  const SizedBox(height: 20),
                  _buildCareerProbabilities(mergedProfile.careerProbabilities),
                ],
              ],
            ),
          ),
        );
      }),
    );
  }

  User _getMergedProfile() {
    final authController = Get.find<AuthController>();
    final authUser = authController.currentUser.value;
    final studentProfile = controller.profile.value;

    debugPrint('Merging profiles - Auth User: ${authUser?.toJson()}');
    debugPrint('Merging profiles - Student Profile: ${studentProfile?.toJson()}');

    // Create a merged profile combining both data sources
    return User(
      id: authUser?.id ?? studentProfile?.id ?? '',
      username: authUser?.username ?? studentProfile?.username ?? '',
      name: authUser?.name ?? studentProfile?.name ?? '',
      email: authUser?.email ?? studentProfile?.email ?? '',
      password: '',
      telephone: authUser?.telephone ?? studentProfile?.telephone ?? '',
      role: authUser?.role ?? studentProfile?.role ?? '',
      active: authUser?.active ?? studentProfile?.active ?? false,
      createdAt: studentProfile?.createdAt ?? authUser?.createdAt ?? DateTime.now(),
      updatedAt: studentProfile?.updatedAt ?? authUser?.updatedAt ?? DateTime.now(),
      school: authUser?.school ?? studentProfile?.school,
      district: authUser?.district ?? studentProfile?.district,
      educationLevel: studentProfile?.educationLevel ?? authUser?.educationLevel ?? 0,
      olResults: studentProfile?.olResults ?? authUser?.olResults ?? {},
      alStream: studentProfile?.alStream ?? authUser?.alStream,
      alResults: studentProfile?.alResults ?? authUser?.alResults ?? {},
      careerProbabilities: studentProfile?.careerProbabilities ?? authUser?.careerProbabilities ?? {},
      gpa: studentProfile?.gpa ?? authUser?.gpa ?? 0.0,
    );
  }

  Widget _buildProfileDetail(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          Text(value.isNotEmpty ? value : 'N/A', style: const TextStyle(fontSize: 16)),
          const Divider(),
        ],
      ),
    );
  }

  Widget _buildResultsDetail(String title, Map<String, double> results) {
    if (results.isEmpty) {
      return const SizedBox.shrink();
    }

    // Convert numeric grades back to letter grades for display
    final formattedResults = results.map((subject, grade) {
      final letterGrade = _getLetterGrade(grade);
      return MapEntry(subject, '$letterGrade (${grade.toStringAsFixed(1)})');
    });

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          ...formattedResults.entries.map((entry) => Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 10.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(entry.key),
                Text(entry.value),
              ],
            ),
          )),
          const Divider(),
        ],
      ),
    );
  }

  String _getLetterGrade(double grade) {
    if (grade >= 85) return 'A';
    if (grade >= 65) return 'B';
    if (grade >= 55) return 'C';
    if (grade >= 45) return 'S';
    return 'F';
  }

  Widget _buildCareerProbabilities(Map<String, double> probabilities) {
    final sortedEntries = probabilities.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Career Recommendations',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 12),
        ...sortedEntries.map((entry) {
          final percentage = (entry.value * 100).toStringAsFixed(1);
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 6.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(entry.key, style: const TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 4),
                Row(
                  children: [
                    Expanded(
                      flex: 8,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: entry.value,
                          backgroundColor: Colors.grey[200],
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.blue[400]!,
                          ),
                          minHeight: 8,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      '$percentage%',
                      style: const TextStyle(fontWeight: FontWeight.w500),
                    ),
                  ],
                ),
              ],
            ),
          );
        }),
        const Divider(height: 32),
      ],
    );
  }

  String getEducationLevelText(int educationLevel) {
    switch (educationLevel) {
      case 0:
        return 'O/L';
      case 1:
        return 'A/L';
      case 2:
        return 'University';
      default:
        return 'Unknown';
    }
  }

  String getALStreamText(int? alStream) {
    switch (alStream) {
      case 6:
        return 'Physical Science';
      case 7:
        return 'Biological Science';
      case 8:
        return 'Physical Science with ICT';
      case 9:
        return 'Bio Science with Agriculture';
      default:
        return 'N/A';
    }
  }
}

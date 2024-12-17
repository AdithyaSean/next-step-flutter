import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';
import 'package:get_it/get_it.dart';
import '../data/repositories/student_repository.dart';
import 'profile_edit.dart';

class ProfileScreen extends StatefulWidget {
  final String studentId;

  const ProfileScreen({super.key, required this.studentId});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final repository = GetIt.instance<StudentRepository>();

    return Scaffold(
      appBar: AppBar(
        title: const Text.rich(
          TextSpan(
            children: [
              TextSpan(
                text: 'NEXT',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 24, // Set the font size for "NEXT"
                ),
              ),
              TextSpan(
                text: ' STEP',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18, // Set the font size for "STEP"
                ),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Handle notification action
            },
          ),
        ],
      ),
      body: StreamBuilder<Map<String, dynamic>?>(
        stream: repository.watchStudent(widget.studentId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final studentData = snapshot.data;
          if (studentData == null) {
            return const Center(child: Text('No profile data found'));
          }

          return LayoutBuilder(
            builder: (context, constraints) {
              if (constraints.maxWidth > 600) {
                return buildWideLayout(context, studentData);
              } else {
                return buildNarrowLayout(context, studentData);
              }
            },
          );
        },
      ),
      bottomNavigationBar: BottomNavContainer(
        selectedIndex: 0,
        studentId: widget.studentId,
      ),
    );
  }

  Widget buildWideLayout(BuildContext context, Map<String, dynamic> studentData) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: buildProfileContent(studentData),
          ),
        ),
        // Additional side content for wide screens
        Expanded(
          flex: 2,
          child: Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(16),
            child: const Center(
              child: Text('Additional Content for Desktop'),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildNarrowLayout(BuildContext context, Map<String, dynamic> studentData) {
    return SingleChildScrollView(
      child: buildProfileContent(studentData),
    );
  }

  Widget buildProfileContent(Map<String, dynamic> studentData) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Column(
              children: [
                const CircleAvatar(
                  radius: 50,
                  backgroundImage: AssetImage('images/profile.png'),
                ),
                const SizedBox(height: 8),
                Text(
                  'Hello ${studentData['name'] ?? ''}',
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Profile completed',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 24),
          buildSectionTitle('Personal Information'),
          buildInfoField('Name', studentData['name'] ?? ''),
          buildInfoField('Email', studentData['email'] ?? ''),
          buildInfoField('Phone', studentData['contact'] ?? ''),

          const SizedBox(height: 24),
          buildSectionTitle('Education'),
          buildEducationItem(
            'Diploma in Software Engineering',
            'Grade: Science',
          ),
          buildEducationItem(
            'Higher National Diploma in Software Engineering',
            '',
          ),

          const SizedBox(height: 24),
          buildSectionTitle('Certifications'),
          buildCertificationItem('Database management'),
          buildCertificationItem('Data Analysis'),

          const SizedBox(height: 24),
          buildSectionTitle('Key Interest'),
          buildInterestTags(['Science', 'Hacking']),
        ],
      ),
    );
  }

  Widget buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.edit),
            iconSize: 20,
            color: Colors.black,
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ProfileEditScreen(studentId: widget.studentId),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildInfoField(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.grey,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildEducationItem(String title, String grade) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        color: Colors.blue[100]!.withOpacity(0.3),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              if (grade.isNotEmpty)
                Text(
                  grade,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[600],
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildCertificationItem(String title) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 0,
        color: Colors.blue[100]!.withOpacity(0.3),
        margin: const EdgeInsets.symmetric(vertical: 4),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }

  Widget buildInterestTags(List<String> interests) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: interests.map((interest) {
        return Chip(
          label: Text(interest),
          backgroundColor: Colors.blue[100]!.withOpacity(0.3),
        );
      }).toList(),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:next_step/nav_bar.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return buildWideLayout(context);
          } else {
            return buildNarrowLayout(context);
          }
        },
      ),
      bottomNavigationBar: const BottomNavContainer(selectedIndex: 0),
    );
  }

  Widget buildWideLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            child: buildProfileContent(),
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

  Widget buildNarrowLayout(BuildContext context) {
    return SingleChildScrollView(
      child: buildProfileContent(),
    );
  }

  Widget buildProfileContent() {
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
                const Text(
                  'Hello Sean',
                  style: TextStyle(
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
          buildInfoField('Name', 'Sean Donaldson'),
          buildInfoField('Email', 'sean@example.com'),
          buildInfoField('Phone', '+94 XXX XXX XXX'),

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
            onPressed: () {
              // Handle edit action
            },
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
    return Container(
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
    return Container(
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
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/controllers/auth_controller.dart';

class ProfileScreen extends GetView<AuthController> {
  const ProfileScreen({super.key});

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(value),
        ],
      ),
    );
  }

  Widget _buildInfoCard(String title, List<Widget> children) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () => Get.toNamed('/profile/edit'),
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => controller.signOut(),
          ),
        ],
      ),
      body: Obx(() {
        final user = controller.currentUser;
        if (user == null) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildInfoCard(
                'Personal Information',
                [
                  _buildInfoRow('Name', user.name),
                  _buildInfoRow('Email', user.email),
                  _buildInfoRow('Telephone', user.telephone),
                ],
              ),
              const SizedBox(height: 16),
              _buildInfoCard(
                'Educational Information',
                [
                  _buildInfoRow('School', user.school),
                  _buildInfoRow('District', user.district),
                  _buildInfoRow('Education Level', 
                    ['O/L', 'A/L', 'University'][user.educationLevel]),
                ],
              ),
              if (user.olResults.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildInfoCard(
                  'O/L Results',
                  user.olResults.entries.map((e) => 
                    _buildInfoRow(e.key, e.value.toString())
                  ).toList(),
                ),
              ],
              if (user.alResults.isNotEmpty) ...[
                const SizedBox(height: 16),
                _buildInfoCard(
                  'A/L Results',
                  [
                    if (user.alStream != null)
                      _buildInfoRow('Stream', 
                        ['Physical Science', 'Bio Science', 'Arts', 'Commerce']
                          [user.alStream! - 6]),
                    ...user.alResults.entries.map((e) => 
                      _buildInfoRow(e.key, e.value.toString())
                    ),
                  ],
                ),
              ],
              if (user.gpa > 0) ...[
                const SizedBox(height: 16),
                _buildInfoCard(
                  'University',
                  [
                    _buildInfoRow('GPA', user.gpa.toString()),
                  ],
                ),
              ],
            ],
          ),
        );
      }),
    );
  }
}

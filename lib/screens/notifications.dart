import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';

class NotificationsScreen extends StatelessWidget {
  final String studentId;

  const NotificationsScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Notifications'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double maxWidth = constraints.maxWidth > 600 ? 600 : constraints.maxWidth;

          return Center(
            child: Container(
              width: maxWidth,
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      'Today',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildNotificationItem(
                    'Expand Your Skills with These Undergraduate Courses!',
                    'Enhance your career opportunities! Check out our courses in Software Development, Digital Marketing, and more, tailored to your current education level.',
                    '09:25 AM',
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '15/9/2024',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildNotificationItem(
                    'Advance Your Career with Specialized Courses!',
                    '',
                    '09:20 AM',
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '14/9/2024',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildNotificationItem(
                    'Master Your Field with Postgraduate Programs!',
                    '',
                    '09:25 AM',
                  ),
                  _buildNotificationItem(
                    'Upgrade Your Skills with Professional Certifications!',
                    '',
                    '09:20 AM',
                  ),
                  const Divider(),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Text(
                      '13/9/2024',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  _buildNotificationItem(
                    'New Courses Available for After A/Level Students',
                    '',
                    '09:20 AM',
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomNavContainer(
        selectedIndex: 2,
        studentId: studentId,
      ),
    );
  }

  Widget _buildNotificationItem(String title, String subtitle, String time) {
    return ListTile(
      leading: const Icon(Icons.notifications),
      title: Text(title),
      subtitle: subtitle.isNotEmpty ? Text(subtitle) : null,
      trailing: Text(time),
      onTap: () {
        // Handle notification tap
      },
    );
  }
}
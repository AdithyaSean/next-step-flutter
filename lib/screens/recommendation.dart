import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';
import 'recommendation_on_interest.dart';
import 'notifications.dart';

class RecommendationsScreen extends StatelessWidget {
  final String studentId;

  const RecommendationsScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('NEXT STEP'),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              // Handle notification action
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NotificationsScreen(studentId: studentId),
                ),
              );
            },
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Adjust the layout based on device size
          if (constraints.maxWidth > 600) {
            return _buildWideLayout(context);
          } else {
            return _buildNarrowLayout(context);
          }
        },
      ),
      bottomNavigationBar: BottomNavContainer(
        selectedIndex: 1,
        studentId: studentId,
      ),
    );
  }

  Widget _buildWideLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: _buildProfileSection(),
        ),
        Expanded(
          flex: 2,
          child: _buildMainContent(context),
        ),
      ],
    );
  }

  Widget _buildNarrowLayout(BuildContext context) {
    return Column(
      children: [
        _buildProfileSection(),
        Expanded(
          child: _buildMainContent(context),
        ),
      ],
    );
  }

  Widget _buildProfileSection() {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          const CircleAvatar(
            radius: 30,
            backgroundImage: AssetImage('images/profile.png'),
          ),
          const SizedBox(height: 16),
          const Text(
            'John Doe',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _buildMainContent(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const TextField(
            decoration: InputDecoration(
              hintText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
            ),
          ),
          const SizedBox(height: 24),
          const Text(
            'Career Paths Based on Your Interests',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          _buildCareerPathButton(context, 'Software Engineering', 2),
          _buildCareerPathButton(context, 'Data Engineering'),
          _buildCareerPathButton(context, 'AI Engineering'),
          _buildCareerPathButton(context, 'Cloud Engineering'),
          _buildCareerPathButton(context, 'Network Engineering'),
        ],
      ),
    );
  }

  Widget _buildCareerPathButton(BuildContext context, String title, [int? notificationCount]) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: ElevatedButton(
        onPressed: () {
          // Handle button press
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => RecommendationOnInterest(studentId: studentId,)));
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          padding: const EdgeInsets.symmetric(vertical: 16),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16), // Add padding to the right of the text
              child: Text(
                title,
                style: const TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
            if (notificationCount != null)
              Container(
                padding: const EdgeInsets.all(6),
                decoration: const BoxDecoration(
                  color: Colors.red,
                  shape: BoxShape.circle,
                ),
                child: Text(
                  notificationCount.toString(),
                  style: const TextStyle(color: Colors.white, fontSize: 12),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

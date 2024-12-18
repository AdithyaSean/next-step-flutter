import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';

class PrivateUniversitiesScreen extends StatelessWidget {
  final String studentId;

  const PrivateUniversitiesScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text('Private Universities'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 1200) {
            return buildDesktopLayout(context);
          } else if (constraints.maxWidth > 600) {
            return buildTabletLayout(context);
          } else {
            return buildMobileLayout(context);
          }
        },
      ),
      bottomNavigationBar:
          BottomNavContainer(selectedIndex: 0, studentId: studentId),
    );
  }

  Widget buildDesktopLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildSearchBar(),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
                childAspectRatio: 1.2,
              ),
              itemCount: universities.length,
              itemBuilder: (context, index) => _buildUniversityCard(
                universities[index],
                context,
                isDesktop: true,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabletLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: 1.1,
              ),
              itemCount: universities.length,
              itemBuilder: (context, index) => _buildUniversityCard(
                universities[index],
                context,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: universities.length,
              itemBuilder: (context, index) => Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: _buildUniversityCard(universities[index], context),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.blue[50],
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: 'Search',
          border: InputBorder.none,
          icon: Icon(Icons.search, color: Colors.grey[600]),
        ),
      ),
    );
  }

  Widget _buildUniversityCard(University university, BuildContext context,
      {bool isDesktop = false}) {
    return Card(
      elevation: 2,
      color: Colors.blue[50],
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              university.logoPath,
              height: isDesktop ? 120 : 80,
              width: isDesktop ? 120 : 80,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 16),
            Text(
              university.name,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Handle view courses action
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                foregroundColor: Colors.white,
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('View Courses'),
            ),
          ],
        ),
      ),
    );
  }
}

class University {
  final String name;
  final String logoPath;

  const University({
    required this.name,
    required this.logoPath,
  });
}

// Sample data
final List<University> universities = [
  const University(
    name: 'NIBM',
    logoPath: 'images/nibm.png',
  ),
  const University(
    name: 'NSBM',
    logoPath: 'images/nsbm.png',
  ),
  // Add more universities as needed
];

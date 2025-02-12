import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';
import 'package:url_launcher/url_launcher.dart';

class CoursesScreen extends StatelessWidget {
  CoursesScreen({super.key});

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
        title: const Text('Courses'),
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
      bottomNavigationBar: const BottomNavContainer(selectedIndex: 2),
    );
  }

  Widget buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        children: [
          _buildSearchBar(),
          const SizedBox(height: 24),
          Expanded(
            child: GridView.builder(
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                childAspectRatio: 2.5,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) =>
                  buildCourseCard(context, courses[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabletLayout(BuildContext context) {
    return Padding(
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
                childAspectRatio: 2.0,
              ),
              itemCount: courses.length,
              itemBuilder: (context, index) =>
                  buildCourseCard(context, courses[index]),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return Column(
      children: [
        _buildSearchBar(),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(16.0),
            itemCount: courses.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: buildCourseCard(context, courses[index]),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      margin: const EdgeInsets.all(10),
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

  Widget buildCourseCard(BuildContext context, Map<String, String> course) {
    return Card(
      elevation: 2,
      color: Colors.blue[50],
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: InkWell(
        onTap: () async {
          if (course['url'] != null && course['url']!.isNotEmpty) {
            final Uri url = Uri.parse(course['url']!);
            if (await canLaunchUrl(url)) {
              await launchUrl(
                url,
                mode: LaunchMode.externalApplication, // Add this line
              );
            } else {
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Could not launch course URL'),
                  ),
                );
              }
            }
          }
        },
        borderRadius: BorderRadius.circular(12),
        child: Container(
          height: 100, // Fixed height for the card
          padding: const EdgeInsets.all(16),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.asset(
                  'images/nibm.png',
                  height: 30,
                  width: 30,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      height: 30,
                      width: 30,
                      color: Colors.grey[300],
                      child: const Icon(Icons.school, color: Colors.grey),
                    );
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      course['name']!,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'NIBM',
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                            color: Colors.grey[600],
                          ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final List<Map<String, String>> courses = [
    {
      'name': 'Diploma in Software Engineering',
      'url': 'https://nibm.lk/course/diploma-in-software-engineering-full-time'
    },
    {
      'name': 'Higher National Diploma in Software Engineering',
      'url':
          'https://nibm.lk/course/higher-national-diploma-in-software-engineering-full-time'
    },
    {
      'name': 'BSc (Hons) Ethical Hacking and Network Security',
      'url':
          'https://nibm.lk/course/bsc-hons-ethical-hacking-and-network-security'
    },
    {
      'name': 'High National Diploma in Logistics',
      'url': '' // Add URL when available
    },
  ];
}

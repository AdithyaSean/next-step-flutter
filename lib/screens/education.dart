import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';

class EducationScreen extends StatelessWidget {
  final String studentId;

  const EducationScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Education'),
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () {
              // Handle edit action
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
      bottomNavigationBar: BottomNavContainer(selectedIndex: 0, studentId: studentId,),
    );
  }

  Widget buildWideLayout(BuildContext context) {
    return Row(
      children: [
        Expanded(
          flex: 1,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: buildEducationContent(),
          ),
        ),
        Expanded(
          flex: 1,
          child: Container(
            color: Colors.grey[100],
            padding: const EdgeInsets.all(16.0),
            child: buildGradesContent(),
          ),
        ),
      ],
    );
  }

  Widget buildNarrowLayout(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildEducationContent(),
            const SizedBox(height: 24),
            buildGradesContent(),
          ],
        ),
      ),
    );
  }

  Widget buildEducationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildEducationCard(
          'Higher National Diploma in Software Engineering',
          'Grade: Distinction',
        ),
        const SizedBox(height: 16),
        buildEducationCard(
          'Diploma in Software Engineering',
          'Grade: Distinction',
        ),
      ],
    );
  }

  Widget buildGradesContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        buildGradeSection(
          'Advanced Level',
          [
            {'subject': 'Combined Mathematics', 'grade': 'A'},
            {'subject': 'Physics', 'grade': 'A'},
            {'subject': 'Chemistry', 'grade': 'A'},
          ],
          zscore: '3.9875',
        ),
        const SizedBox(height: 24),
        buildGradeSection(
          'Ordinary Level',
          [
            {'subject': 'Sinhala', 'grade': 'A'},
            {'subject': 'Buddhism', 'grade': 'A'},
            {'subject': 'Science', 'grade': 'A'},
            {'subject': 'English', 'grade': 'A'},
            {'subject': 'History', 'grade': 'A'},
            {'subject': 'Commerce', 'grade': 'A'},
            {'subject': 'Music', 'grade': 'A'},
            {'subject': 'ICT', 'grade': 'A'},
          ],
        ),
      ],
    );
  }

  Widget buildEducationCard(String title, String grade) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              grade,
              style: const TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildGradeSection(String title, List<Map<String, String>> grades, {String? zscore}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...grades.map((grade) => Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(grade['subject']!),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  grade['grade']!,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        )),
        if (zscore != null) ...[
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Z-Score'),
              Text(
                zscore,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ],
      ],
    );
  }
}
import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';

class RecommendationOnInterest extends StatelessWidget {
  final String studentId;
  const RecommendationOnInterest({super.key, required this.studentId});

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
        title: const Text('Recommendations'),
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
      bottomNavigationBar: BottomNavContainer(selectedIndex: 1, studentId: studentId),
    );
  }

  Widget buildDesktopLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildSearchBar(),
          Expanded(
            flex: 1,
            child: buildRecommendationCard(
              'Higher National Diploma',
              '1. HND in Software Engineering',
              [
                'Successfully Followed the Diploma in Computer System Design',
                'Successfully Followed the Diploma in Software Engineering',
              ],
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            flex: 1,
            child: buildRecommendationCard(
              'Degree',
              '1. Degree in Computing',
              [
                'A/L Option: Minimum 2 passes at G.C.E A/L in Mathematics/Science Streams & Technology stream with ICT',
                'O/L Option: Minimum 5 passes including Mathematics, Science & Technology stream with ICT',
                'Passed G.C.E O/L including "B" passes for Mathematics and Science/ICT and "C" pass for English',
                'Successfully completed a certificate program specialized in Software Engineering at NIBM',
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTabletLayout(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          _buildSearchBar(),
          buildRecommendationCard(
            'Higher National Diploma',
            '1. HND in Software Engineering',
            [
              'Successfully Followed the Diploma in Computer System Design',
              'Successfully Followed the Diploma in Software Engineering',
            ],
          ),
          SizedBox(height: 10),
          buildRecommendationCard(
            'Degree',
            '1. Degree in Computing',
            [
              'A/L Option: Minimum 2 passes at G.C.E A/L in Mathematics/Science Streams & Technology stream with ICT',
              'O/L Option: Minimum 5 passes including Mathematics, Science & Technology stream with ICT',
              'Passed G.C.E O/L including "B" passes for Mathematics and Science/ICT and "C" pass for English',
              'Successfully completed a certificate program specialized in Software Engineering at NIBM',
            ],
          ),
        ],
      ),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(10.0),
      children: [
        _buildSearchBar(),
        buildRecommendationCard(
          'Higher National Diploma',
          '1. HND in Software Engineering',
          [
            'Successfully Followed the Diploma in Computer System Design',
            'Successfully Followed the Diploma in Software Engineering',
          ],
        ),
        SizedBox(height: 10),
        buildRecommendationCard(
          'Degree',
          '1. Degree in Computing',
          [
            'A/L Option: Minimum 2 passes at G.C.E A/L in Mathematics/Science Streams & Technology stream with ICT',
            'O/L Option: Minimum 5 passes including Mathematics, Science & Technology stream with ICT',
            'Passed G.C.E O/L including "B" passes for Mathematics and Science/ICT and "C" pass for English',
            'Successfully completed a certificate program specialized in Software Engineering at NIBM',
          ],
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

  Widget buildRecommendationCard(String category, String title, List<String> qualifications) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(color: Colors.blue[300]!, width: 1),
      ),
      elevation: 3,
      color: Colors.blue[50],
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              category,
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.blue),
            ),
            SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            for (var qualification in qualifications)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 4.0),
                child: Text(
                  '• $qualification',
                  style: TextStyle(fontSize: 14),
                ),
              ),
            SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.white,
                ),
                child: Text('More'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

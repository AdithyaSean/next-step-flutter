import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:next_step/screens/home.dart';
import 'package:next_step/screens/recommendation.dart';
import 'package:next_step/screens/explore.dart';
import 'package:next_step/screens/settings_Ui.dart';

class BottomNavContainer extends StatelessWidget {
  final int selectedIndex;
  final String studentId; // Add studentId parameter

  const BottomNavContainer({
    super.key,
    required this.selectedIndex,
    required this.studentId, // Add to constructor
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 20),
        child: GNav(
          backgroundColor: Colors.black,
          color: Colors.white,
          activeColor: Colors.white,
          tabBackgroundColor: Colors.grey.shade800,
          gap: 8,
          padding: EdgeInsets.all(16),
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            switch(index) {
              case 0:
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomeScreen(studentId: studentId)));
                break;
              case 1:
                Navigator.push(context, MaterialPageRoute(builder: (context) => RecommendationsScreen(studentId: studentId)));
                break;
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (context) => ExploreScreen(studentId: studentId)));
                break;
              case 3:
                Navigator.push(context, MaterialPageRoute(builder: (context) => ResponsiveSettings(studentId: studentId)));
                break;
            }
          },
          tabs: [
            GButton(
              icon: Icons.home,
              text: 'Home',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => HomeScreen(studentId: studentId),
                  ),
                );
              },
            ),
            GButton(
              icon: Icons.workspace_premium,
              text: 'Recommend',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => RecommendationsScreen(studentId: studentId),
                  ),
                );
              },
            ),
            GButton(
              icon: Icons.language,
              text: 'Explore',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ExploreScreen(studentId: studentId),
                  ),
                );
              },
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
              onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(
                     builder: (context) => ResponsiveSettings(studentId: studentId),
                   ),
                 );
              },
            ),
          ],
        ),
      ),
    );
  }
}
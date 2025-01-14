import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:next_step/screens/home.dart';
import 'package:next_step/screens/recommendation.dart';
import 'package:next_step/screens/explore.dart';
import 'package:next_step/screens/settings_Ui.dart';

class BottomNavContainer extends StatelessWidget {
  final int selectedIndex;
  const BottomNavContainer({super.key, this.selectedIndex = 0});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
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
          padding: const EdgeInsets.all(16),
          selectedIndex: selectedIndex,
          onTabChange: (index) {
            switch(index) {
              case 0:
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HomeScreen()));
                break;
              case 1:
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RecommendationsScreen()));
                break;
              case 2:
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ExploreScreen()));
                break;
              case 3:
                Navigator.push(context, MaterialPageRoute(builder: (context) => const ResponsiveSettings()));
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
                  MaterialPageRoute(builder: (context) => const HomeScreen()),
                );
              },
            ),
            GButton(
              icon: Icons.workspace_premium,
              text: 'Recommend',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const RecommendationsScreen()),
                );
              },
            ),
            GButton(
              icon: Icons.language,
              text: 'Explore',
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const ExploreScreen()),
                );
              },
            ),
            GButton(
              icon: Icons.settings,
              text: 'Settings',
              onPressed: () {
                 Navigator.push(
                   context,
                   MaterialPageRoute(builder: (context) => const ResponsiveSettings()),
                 );
              },
            ),
          ],
        ),
      ),
    );
  }
}
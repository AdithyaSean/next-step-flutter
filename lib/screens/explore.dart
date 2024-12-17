import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';

class ExploreScreen extends StatelessWidget {
  final String studentId;

  const ExploreScreen({super.key, required this.studentId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'NEXT STEP',
          style: TextStyle(fontWeight: FontWeight.bold),
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
          if (constraints.maxWidth > 1200) {
            return buildDesktopLayout(context);
          } else if (constraints.maxWidth > 600) {
            return buildTabletLayout(context);
          } else {
            return buildMobileLayout(context);
          }
        },
      ),
      bottomNavigationBar: BottomNavContainer(
        selectedIndex: 2,
        studentId: studentId,
      ),
    );
  }

  Widget _buildProfileSection() {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
      ),
    );
  }

  Widget buildDesktopLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileSection(),
          const SizedBox(height: 24),
          _buildSearchBar(),
          const SizedBox(height: 32),
          _buildSectionGrid(isDesktop: true),
        ],
      ),
    );
  }

  Widget buildTabletLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileSection(),
          const SizedBox(height: 20),
          _buildSearchBar(),
          const SizedBox(height: 24),
          _buildSectionGrid(isTablet: true),
        ],
      ),
    );
  }

  Widget buildMobileLayout(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildProfileSection(),
          const SizedBox(height: 16),
          _buildSearchBar(),
          const SizedBox(height: 20),
          _buildSectionList(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return TextField(
      decoration: InputDecoration(
        hintText: 'Explore',
        prefixIcon: const Icon(Icons.search),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        filled: true,
        fillColor: Colors.grey[100],
      ),
    );
  }

  Widget _buildSectionGrid({bool isDesktop = false, bool isTablet = false}) {
    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: isDesktop ? 4 : (isTablet ? 3 : 2),
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 1.2,
      ),
      children: [
        _buildSection('Universities', []),
        _buildSection('Government', [
          _buildUniversityCard(
            'University of Colombo',
            'images/uo_colombo.png',
            Colors.blue[50]!,
          ),
          _buildUniversityCard(
            'University of Moratuwa',
            'images/uo_moratuwa.png',
            Colors.red[50]!,
          ),
          _buildUniversityCard(
            'Open Uni',
            'images/open_uni.png',
            Colors.orange[50]!,
          ),
        ]),
        _buildSection('Private Uni', [
          _buildUniversityCard(
            'NIBM',
            'images/nibm.png',
            Colors.blue[50]!,
          ),
          _buildUniversityCard(
            'NSBM',
            'images/nsbm.png',
            Colors.green[50]!,
          ),
          _buildUniversityCard(
            'SLIT',
            'images/sllit.png',
            Colors.purple[50]!,
          ),
        ]),
      ],
    );
  }

  Widget _buildSectionList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader('Government Uni'),
        const SizedBox(height: 12),
        _buildHorizontalScroll([
          _buildUniversityCard(
            'University of Colombo',
            'images/uo_colombo.png',
            Colors.blue[50]!,
          ),
          _buildUniversityCard(
            'University of Moratuwa',
            'images/uo_moratuwa.png',
            Colors.red[50]!,
          ),
          _buildUniversityCard(
            'Open Uni',
            'images/open_uni.png',
            Colors.orange[50]!,
          ),
        ]),
        const SizedBox(height: 24),
        _buildSectionHeader('Private Uni'),
        const SizedBox(height: 12),
        _buildHorizontalScroll([
          _buildUniversityCard(
            'NIBM',
            'images/nibm.png',
            Colors.blue[50]!,
          ),
          _buildUniversityCard(
            'NSBM',
            'images/nsbm.png',
            Colors.green[50]!,
          ),
          _buildUniversityCard(
            'SLIT',
            'images/sllit.png',
            Colors.purple[50]!,
          ),
        ]),
      ],
    );
  }

  Widget _buildSection(String title, List<Widget> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildSectionHeader(title),
        const SizedBox(height: 8),
        ...items,
      ],
    );
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildHorizontalScroll(List<Widget> items) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: items
            .map((item) => Padding(
          padding: const EdgeInsets.only(right: 12),
          child: item,
        ))
            .toList(),
      ),
    );
  }

  Widget _buildUniversityCard(String name, String logoPath, Color backgroundColor) {
    return Card(
      elevation: 0,
      color: backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Container(
        width: 120,
        height: 120,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              logoPath,
              width: 46,
              height: 44,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
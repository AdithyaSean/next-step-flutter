import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/controllers/student_controller.dart';
import '../services/auth_service.dart';
import 'sign_in.dart';
import 'notifications.dart';
import '../widgets/nav_bar.dart';
import 'profile.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  UserDTO? _user;

  @override
  void initState() {
    super.initState();
    checkSession();
  }

  Future<void> checkSession() async {
    final authService = Get.find<AuthService>();
    final isLoggedIn = await authService.isLoggedIn();

    if (!isLoggedIn && mounted) {
      Get.offAll(() => ResponsiveSignIn());
      return;
    }

    _loadUser();
  }

  Future<void> _loadUser() async {
    final authService = Get.find<AuthService>();
    final userProfile = await authService.getUserProfile();

    if (mounted) {
      setState(() {
        _user = userProfile;
      });

      if (userProfile == null) {
        Get.offAll(() => ResponsiveSignIn()); // Use Get for navigation
      }
    }
  }

  Widget _buildCareerProbabilities() {
    final studentController = Get.find<StudentController>();
    final profile = studentController.profile.value;
    
    if (profile == null || profile.careerProbabilities.isEmpty) {
      return const SizedBox.shrink();
    }
  
    final sortedProbabilities = profile.careerProbabilities.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
  
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Top career paths for you',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: 300,
          child: ListView(
            children: sortedProbabilities.map((entry) => 
              CareerPathProgress(
                title: entry.key,
                percentage: entry.value,
              ),
            ).toList(),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    if (_user == null) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: GestureDetector(
          onTap: () => Get.to(() => const ProfileScreen()),
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: CircleAvatar(
              backgroundImage: AssetImage('images/profile.png'),
            ),
          ),
        ),
        title: const Text(
          'NEXT STEP',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 24,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_outlined),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const NotificationsScreen(),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Welcome ${_user!.username}', // dynamic welcome
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Search',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[200],
                ),
              ),
              const SizedBox(height: 20),
              const Text(
                'Key Interest',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InterestCard(
                    title: 'Software Engineering',
                    imagePath: 'images/se.png',
                  ),
                  InterestCard(
                    title: 'Data Scientist',
                    imagePath: 'images/dataSci.png',
                  ),
                  InterestCard(
                    title: 'AI Engineer',
                    imagePath: 'images/AIEng.png',
                  ),
                ],
              ),
              const SizedBox(height: 20),
              _buildCareerProbabilities(),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50),
                    ),
                    minimumSize: const Size(200, 50),
                  ),
                  child: const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15, horizontal: 30),
                    child: Text(
                      'PREDICT',
                      style: TextStyle(fontSize: 16, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: const BottomNavContainer(selectedIndex: 0),
    );
  }
}

class InterestCard extends StatelessWidget {
  final String title;
  final String imagePath;

  const InterestCard({required this.title, required this.imagePath, super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        children: [
          Image.asset(
            imagePath,
            width: 40,
            height: 40,
            fit: BoxFit.cover,
          ),
          const SizedBox(height: 5),
          Text(title, style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class CareerPathProgress extends StatelessWidget {
  final String title;
  final double percentage;

  const CareerPathProgress(
      {required this.title, required this.percentage, super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Stack(
            children: [
              Container(
                height: 20,
                decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(15),
                ),
              ),
              FractionallySizedBox(
                widthFactor: percentage,
                child: Container(
                  height: 20,
                  decoration: BoxDecoration(
                    color: Colors.blue,
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.centerRight,
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8),
                    child: Text(
                      '${(percentage * 100).toInt()}%',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

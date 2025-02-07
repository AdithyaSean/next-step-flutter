import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/controllers/student_controller.dart';
import 'package:next_step/screens/profile.dart';
import 'package:next_step/widgets/nav_bar.dart';

import 'notifications.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final StudentController _studentController = Get.find<StudentController>();

  @override
  void initState() {
    super.initState();
    _studentController.loadProfile();
  }

  @override
  Widget build(BuildContext context) {
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
      body: Obx(() => _studentController.isLoading.value 
          ? const Center(child: CircularProgressIndicator())
          : _studentController.profile.value == null
              ? Center(
                  child: ElevatedButton(
                    onPressed: () => Get.to(() => const ProfileScreen()),
                    child: const Text('Complete Profile'),
                  ),
                )
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Obx(() => Text(
                      'Welcome ${_studentController.profile.value?.username ?? ""}',
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    )),
                    const SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search Careers',
                          prefixIcon: const Icon(Icons.search),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                            borderSide: BorderSide.none,
                          ),
                          filled: true,
                          fillColor: Colors.grey[200],
                        ),
                      ),
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Text(
                        'Top Career Matches For You',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Obx(() => Column(
                      children: _buildCareerProbabilities(),
                    )),
                    const SizedBox(height: 30),
                    Center(
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        child: const Text(
                          'PREDICT',
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )),
      bottomNavigationBar: const BottomNavContainer(selectedIndex: 0),
    );
  }

  List<Widget> _buildCareerProbabilities() {
    final user = _studentController.profile.value;
    debugPrint('Building career probabilities, user: ${user?.toJson()}');
    if (user == null || user.careerProbabilities.isEmpty) {
      return [const Text('No career probabilities available.')];
    }

    return user.careerProbabilities.entries.map<Widget>((entry) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(
              width: 150,
              child: Text(
                entry.key,
                style: const TextStyle(fontSize: 16),
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: SizedBox(
                  height: 20, // Increased height
                  child: Stack(
                    alignment: Alignment.centerRight,
                    children: [
                      ClipRRect(
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey[400]!, width: 0.5),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: LinearProgressIndicator(
                            value: entry.value,
                            backgroundColor: Colors.grey[300],
                            color: Colors.blueAccent,
                            minHeight: 20,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${(entry.value * 100).toStringAsFixed(1)}%',
                          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w900, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}

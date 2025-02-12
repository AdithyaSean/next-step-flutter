import 'package:flutter/material.dart';
import 'package:next_step/screens/sign_in.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({super.key});

  @override
  InterestsPageState createState() => InterestsPageState();
}

class InterestsPageState extends State<InterestsPage> {
  List<String> interests = [
    "AI",
    "Science",
    "Mathematics",
    "Computer Science",
    "Biology",
    "Physics",
    "English",
    "Law",
    "Music",
    "Dancing",
    "History",
    "Languages",
    "Robotics",
    "Drama",
    "Computer Networks",
    "Hacking",
    "Chemistry",
    "Engineering"
  ];

  List<String> selectedInterests = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              'Choose Your Interests',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Wrap(
              spacing: 18.0,
              runSpacing: 18.0,
              children: interests.map((interest) {
                bool isSelected = selectedInterests.contains(interest);
                return ChoiceChip(
                  label: Text(
                    interest,
                    style: const TextStyle(fontSize: 17), // Increase text size
                  ),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      if (selected) {
                        selectedInterests.add(interest);
                      } else {
                        selectedInterests.remove(interest);
                      }
                    });
                  },
                  selectedColor: Colors.blue,
                  backgroundColor: Colors.grey[300],
                  labelPadding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 8), // Increase padding
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                );
              }).toList(),
            ),
            const Spacer(),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ResponsiveSignIn()));

                  // Handle the "Next" button press
                  debugPrint('Selected Interests: $selectedInterests');
                },
                style: ElevatedButton.styleFrom(
                  textStyle: const TextStyle(
                      fontSize: 18,
                      color: Colors.black,
                      fontWeight: FontWeight.bold),
                  backgroundColor: Colors.blue,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                ),
                child: const Text('Next'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

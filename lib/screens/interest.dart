import 'package:flutter/material.dart';
import 'package:next_step/screens/sign_in.dart';

class InterestsPage extends StatefulWidget {
  const InterestsPage({super.key});

  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
  List<String> interests = [
    "Artificial Intelligence",
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
    "Cybersecurity",
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
            Text(
              'Choose Your Interests',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 40,),
            Expanded( // Added Expanded
              child: SingleChildScrollView( // Added SingleChildScrollView
                child: Column( // Added Column
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Wrap(
                      spacing: 18.0,
                      runSpacing: 18.0,
                      children: interests.map((interest) {
                        bool isSelected = selectedInterests.contains(interest);
                        return ChoiceChip(
                          label: Text(
                            interest,
                            style: TextStyle(fontSize: 17), // Increase text size
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
                          labelPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 8), // Increase padding
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 20), // Added SizedBox for spacing
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => const ResponsiveSignIn()));

                          // Handle the "Next" button press
                          print("Selected Interests: $selectedInterests");
                        },
                        style: ElevatedButton.styleFrom(
                          textStyle: TextStyle(fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold),
                          backgroundColor: Colors.blue,
                          padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                        ),
                        child: Text('Next'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

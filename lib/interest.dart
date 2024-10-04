import 'package:flutter/material.dart';

class InterestsPage extends StatefulWidget {
  @override
  _InterestsPageState createState() => _InterestsPageState();
}

class _InterestsPageState extends State<InterestsPage> {
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Choose Your Interests',
              style: TextStyle(
                color: Colors.black,
                fontSize: 30,
                fontWeight: FontWeight.bold,

              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 40,),
            Wrap(
              spacing: 20.0,
              runSpacing: 20.0,
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
                borderRadius: BorderRadius.circular(20.0),),
                );
              }).toList(),
            ),
            Spacer(),
            Center(
            child: ElevatedButton(
              onPressed: () {
                // Handle the "Next" button press
                print("Selected Interests: $selectedInterests");
              },
              child: Text('Next'),
              style: ElevatedButton.styleFrom(
                textStyle: TextStyle(fontSize: 18 , color: Colors.black , fontWeight: FontWeight.bold),
                backgroundColor: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
              ),
            ),
          ),
          ],
        ),
      ),
    );
  }
}

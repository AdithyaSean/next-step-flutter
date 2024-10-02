import 'package:flutter/material.dart';

class NextStepStart extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            // Illustration Image at the top
            Padding(
              padding: const EdgeInsets.only(top: 50.0),
              child: Center(
                child: Container(
                  height: 200,
                  width: 200,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/next_step.png'), // Top Image
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),

            // New Image fitting the screen width
            Expanded(
              child: Center(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('images/start.jpg'), // Add another image here
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),

            // Get Started Button at the bottom
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    // Add navigation or functionality here
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Background color
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                  ),
                  child: Text(
                    'Get Start',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
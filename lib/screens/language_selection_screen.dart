import 'package:flutter/material.dart';
import 'interest.dart';

class LanguageSelectionScreen extends StatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Choose Your Language',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            _buildLanguageOption('English'),
            _buildLanguageOption('Sinhala'),
            _buildLanguageOption('Tamil'),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Handle button press
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) =>  InterestsPage()));
                  print('Selected Language: $_selectedLanguage');
                },
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: Colors.blue, // Use backgroundColor instead of primary
                ),
                child: const Text(
                  'Next',
                  style: TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageOption(String language) {
    return Card(
      color: Colors.white.withOpacity(0.7),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: RadioListTile<String>(
        title: Text(language, style: const TextStyle(fontSize: 18)),
        value: language,
        groupValue: _selectedLanguage,
        activeColor: Colors.black,
        onChanged: (String? value) {
          setState(() {
            _selectedLanguage = value!;
          });
        },
      ),
    );
  }
}
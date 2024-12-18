import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';

class LanguageSelectionScreen extends StatefulWidget {
  final String studentId;
  
  const LanguageSelectionScreen({super.key, required this.studentId});

  @override
  _LanguageSelectionScreenState createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState extends State<LanguageSelectionScreen> {
  String _selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    var studentId = widget.studentId;
    
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Language'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          double formWidth = constraints.maxWidth;
          if (constraints.maxWidth > 600) {
            formWidth = constraints.maxWidth * 0.5;
          }
          if (constraints.maxWidth > 1200) {
            formWidth = constraints.maxWidth * 0.3;
          }

          return SingleChildScrollView(
            child: Container(
              width: formWidth,
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Select a Language',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.left,
                  ),
                  const SizedBox(height: 50),
                  _buildLanguageOption('English'),
                  const SizedBox(height: 16),
                  _buildLanguageOption('Sinhala'),
                  const SizedBox(height: 16),
                  _buildLanguageOption('Tamil'),
                  const SizedBox(height: 260),
                  ElevatedButton(
                    onPressed: () {
                      // Implement save logic
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:
          BottomNavContainer(selectedIndex: 3, studentId: studentId),
    );
  }

  Widget _buildLanguageOption(String language) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(30),
      ),
      child: ListTile(
        title: Text(
          language,
          style: const TextStyle(fontSize: 16),
        ),
        trailing: Radio<String>(
          value: language,
          groupValue: _selectedLanguage,
          onChanged: (String? value) {
            setState(() {
              _selectedLanguage = value!;
            });
          },
        ),
      ),
    );
  }
}

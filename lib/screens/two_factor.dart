import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';
import 'package:next_step/screens/two_factor_email.dart';
import 'package:next_step/screens/two_factor_mobile.dart';

class TwoFactorAuthScreen extends StatefulWidget {
  final String studentId;

  const TwoFactorAuthScreen({super.key, required this.studentId});

  @override
  _TwoFactorAuthScreenState createState() => _TwoFactorAuthScreenState();
}

class _TwoFactorAuthScreenState extends State<TwoFactorAuthScreen> {

  @override
  Widget build(BuildContext context) {
    var studentId = widget.studentId;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('2-Factor authentication'),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          // Determine the form width based on screen size
          double formWidth = constraints.maxWidth;
          if (constraints.maxWidth > 600) {
            formWidth = constraints.maxWidth * 0.5;
          }
          if (constraints.maxWidth > 1200) {
            formWidth = constraints.maxWidth * 0.3;
          }

          return Center(
            child: SingleChildScrollView(
              child: Container(
                width: formWidth,
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 20),
                    ElevatedButton.icon(
                      onPressed: () {
                        _selectMethod('mobile');
                        var studentID = widget.studentId;
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) =>
                                  TwoFactorAuthScreenMobile(studentId: studentID,)),
                        );
                      },
                      icon:
                          const Icon(Icons.phone_android, color: Colors.white),
                      label: const Text(
                        'Mobile',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Text color always white
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Background always blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton.icon(
                      onPressed: () {
                        _selectMethod('email');
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EmailTwoFactorAuthScreen(studentId: studentId,)),
                        );
                      },
                      icon: const Icon(Icons.email, color: Colors.white),
                      label: const Text(
                        'Email',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white, // Text color always white
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue, // Background always blue
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar:
          BottomNavContainer(selectedIndex: 3, studentId: studentId),
    );
  }

  Widget _buildAuthOption(String title, IconData icon,
      {required VoidCallback onTap, required bool isSelected}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
            width: isSelected ? 2 : 1,
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: ListTile(
          leading: Icon(icon, color: Colors.white), // Icon color always white
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white, // Text color always white
              fontWeight: FontWeight.bold,
            ),
          ),
          trailing: isSelected
              ? const Icon(Icons.check_circle, color: Colors.blue)
              : null,
        ),
      ),
    );
  }

  void _selectMethod(String method) {
    setState(() {
    });
  }
}

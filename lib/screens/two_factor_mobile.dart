import 'package:flutter/material.dart';
import 'package:next_step/widgets/nav_bar.dart';

class TwoFactorAuthScreenMobile extends StatefulWidget {
  const TwoFactorAuthScreenMobile({super.key});

  @override
  TwoFactorAuthScreenState createState() => TwoFactorAuthScreenState();
}

class TwoFactorAuthScreenState extends State<TwoFactorAuthScreenMobile> {
  final TextEditingController _mobileController = TextEditingController();
  final TextEditingController _otpController = TextEditingController();
  bool _otpSent = false;

  @override
  Widget build(BuildContext context) {
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
                    TextField(
                      controller: _mobileController,
                      decoration: InputDecoration(
                        labelText: 'Enter your Mobile Number',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        prefixText: _otpSent ? '+94 ' : null,
                      ),
                      keyboardType: TextInputType.phone,
                      enabled: !_otpSent,
                    ),
                    const SizedBox(height: 16),
                    if (_otpSent)
                      TextField(
                        controller: _otpController,
                        decoration: InputDecoration(
                          labelText: 'OTP',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                        keyboardType: TextInputType.number,
                      ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          _otpSent = !_otpSent;
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(_otpSent ? 'Verify OTP' : 'Send OTP'),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const BottomNavContainer(selectedIndex: 3),
    );
  }
}
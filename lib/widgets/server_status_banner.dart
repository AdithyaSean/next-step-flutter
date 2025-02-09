import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../services/student_service.dart';

class ServerStatusBanner extends StatelessWidget {
  final StudentService studentService = Get.find<StudentService>();

  ServerStatusBanner({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (!studentService.isServerAvailable) {
        return Container(
          width: double.infinity,
          color: Colors.red.shade100,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
          child: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.red),
              const SizedBox(width: 8),
              const Expanded(
                child: Text(
                  'Unable to connect to server. Please ensure the server is running and accessible.',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.refresh, color: Colors.red),
                onPressed: () {
                  studentService.initAsync();
                },
              ),
            ],
          ),
        );
      }
      return const SizedBox.shrink();
    });
  }
}

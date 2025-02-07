import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/controllers/auth_controller.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;

  const LoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Stack(
      children: [
        child,
        Obx(() {
          return controller.isLoading
              ? Container(
                  color: Colors.black.withAlpha(77), // 30% opacity
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink();
        }),
      ],
    );
  }
}

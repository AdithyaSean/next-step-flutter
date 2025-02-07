import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;

  const LoadingOverlay({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AuthController>(
      global: true,
      autoRemove: false,
      init: Get.find<AuthController>(),
      builder: (controller) => Stack(
      children: [
        child,
        Obx(() {
          return controller.isLoading.value
              ? Container(
                  color: Colors.black54,
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : const SizedBox.shrink();
        }),
      ],
    ));
  }
}

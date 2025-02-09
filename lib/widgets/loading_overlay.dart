import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:next_step/controllers/auth_controller.dart';
import 'package:next_step/widgets/server_status_banner.dart';

class LoadingOverlay extends StatelessWidget {
  final Widget child;
  final bool showServerStatus;

  const LoadingOverlay({
    super.key, 
    required this.child,
    this.showServerStatus = true,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<AuthController>();

    return Stack(
      children: [
        Column(
          children: [
            if (showServerStatus) ServerStatusBanner(),
            Expanded(child: child),
          ],
        ),
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

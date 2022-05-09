import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'api_firestore.dart';

void callNotification() {
  Future.delayed(const Duration(milliseconds: 500), () {
    Get.snackbar("Recommendation", "based on your previous orders",
        messageText: NotificationToast());
  });
}

class NotificationToast extends StatelessWidget {
  NotificationToast({Key? key}) : super(key: key);
  final api = Get.find<ApiService>();

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () async {
        Get.toNamed("/serviceinfo", arguments: [(await api.getServices())[0]]);
      },
      child: const Text("view"),
    );
  }
}

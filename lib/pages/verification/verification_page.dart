import 'package:flutter/material.dart';
import 'package:get/get.dart';

class VerificationController extends GetxController {
  Image? cnic;
  Image? person;
}

class VerificationBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerificationController());
  }
}

//@todo add verification
class VerificationPage extends GetView<VerificationController> {
  final String title = "Verify";

  const VerificationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(letterSpacing: 3)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: () {},
              child: const Text("Upload CNIC"),
            ),
          ],
        ),
      ),
    );
  }
}

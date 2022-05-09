import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/api_firestore.dart';
import 'package:kaamai/services/session.dart';
import 'package:kaamai/widgets/background_gradient.dart';

class HistoryPage extends StatelessWidget {
  HistoryPage({Key? key}) : super(key: key);

  final ApiService api = Get.find<ApiService>();
  final session = Get.find<Session>();
  final String title = "History";

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient2(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: const TextStyle(letterSpacing: 3)),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  const SizedBox(height: 50),
                  const Text(
                    'No Logs',
                    textScaleFactor: 2,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 300),
                  const Text(
                    '7 Day Streak',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      // color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  TextButton(
                    onPressed: () {},
                    child: const Text(
                      'View last order',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                  const SizedBox(height: 50),
                  SizedBox(
                    width: double.maxFinite,
                    child: ElevatedButton(
                      onPressed: () {},
                      child: const Text(
                        "Clear Log",
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

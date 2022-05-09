import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/session.dart';

class ProfileCard extends StatelessWidget {
  ProfileCard({Key? key}) : super(key: key);
  final session = Get.find<Session>();

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1.7,
      child: Card(
        elevation: 5,
        semanticContainer: true,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/cardbg2.png"),
              fit: BoxFit.fitWidth,
            ),
          ),
          padding: const EdgeInsets.symmetric(vertical: 24.0, horizontal: 12),
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              //@todo get current date and format
              const Text(
                "Sunday, 10th October",
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 12,
              ),
              Text(
                session.userData["name"],
                textScaleFactor: 1.5,
                style: const TextStyle(color: Colors.white),
              ),
              const Divider(),
              const Text(
                "Total Earnings",
                textScaleFactor: 1.2,
                style: TextStyle(color: Colors.white),
              ),
              const SizedBox(
                height: 4,
              ),
              const Text(
                " 6,142 Rs.",
                textScaleFactor: 3,
                textAlign: TextAlign.left,
                style: TextStyle(color: Colors.white),
              ),
              // Text("${DateTime.now().day}"),
            ],
          ),
        ),
      ),
    );
  }
}

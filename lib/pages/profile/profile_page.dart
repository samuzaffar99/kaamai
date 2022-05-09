import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/pages/home/profile_card.dart';
import 'package:kaamai/services/api_firestore.dart';
import 'package:kaamai/services/session.dart';
import 'package:kaamai/widgets/background_gradient.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({Key? key}) : super(key: key);

  final ApiService api = Get.find<ApiService>();
  final session = Get.find<Session>();
  final String title = "My Profile";

  @override
  Widget build(BuildContext context) {
    return BackgroundGradient2(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title, style: const TextStyle(letterSpacing: 3)),
          backgroundColor: Colors.transparent,
          elevation: 0,
          centerTitle: true,
        ),
        backgroundColor: Colors.transparent,
        body: Padding(
          padding: const EdgeInsets.all(8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              const SizedBox(height: 20),
              ProfileCard(),
              ElevatedButton(
                child: const Text("Verify Profile"),
                style: ElevatedButton.styleFrom(primary: Colors.purpleAccent),
                onPressed: () {
                  Get.toNamed("/verify");
                },
              ),
              ElevatedButton(
                onPressed: () {
                  //  @todo update profile
                },
                child: const Text("Update Profile"),
                style: ElevatedButton.styleFrom(primary: Colors.amber),
              ),
              const Spacer(),
              ElevatedButton(
                onPressed: () {
                  session.deleteUser();
                  Get.offAllNamed("/");
                },
                child: const Text("Deactivate Account"),
                style: ElevatedButton.styleFrom(primary: Colors.red),
              ),
              const SizedBox(height: 36),
              // const Divider(),
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/session.dart';
import 'package:kaamai/services/utils.dart';

class SettingsPage extends StatelessWidget {
  SettingsPage({Key? key}) : super(key: key);
  final String title = "Settings";
  final List<bool> isSelected = [false];
  final session = Get.find<Session>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text(title, style: const TextStyle(letterSpacing: 3)),
        centerTitle: true,
        // elevation: 3,
      ),
      body: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            const SizedBox(height: 24),
            Row(
              children: [
                const Expanded(child: Text("Dark Mode")),
                Switch(
                  value: isSelected[0],
                  onChanged: (bool value) {
                    isSelected[0] = !isSelected[0];
                  },
                ),
              ],
            ),
            const SizedBox(height: 24),
            const Text("Account Settings"),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                session.signOut();
                Get.offAllNamed("/");
              },
              child: const Text("Logout"),
              style: ElevatedButton.styleFrom(primary: Colors.redAccent),
            ),
            // ElevatedButton(
            //   onPressed: () {
            //     //@todo remove from production unless role is admin
            //     // Get.toNamed("/admin");
            //   },
            //   child: const Text("Admin"),
            //   style: ElevatedButton.styleFrom(primary: Colors.red),
            // ),
            ElevatedButton(
              onPressed: () {
                session.deleteUser();
                Get.offAllNamed("/");
              },
              child: const Text("Deactivate Account"),
              style: ElevatedButton.styleFrom(primary: Colors.red),
            ),
            const Spacer(),
            Column(
              children: const [
                Text(
                  "Developed By",
                  textScaleFactor: 1.2,
                ),
                SizedBox(
                  height: 12,
                ),
                Text("Kaamai",
                    textScaleFactor: 2,
                    style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(
                  height: 12,
                ),
                Text("Syed Abdullah Muzaffar"),
                Text("Humna Faisal"),
              ],
            ),
            const SizedBox(height: 12),
            ElevatedButton.icon(
              onPressed: () =>
                  launchURL('https://www.facebook.com/DevelopersDay/'),
              label: const Text("Play Store"),
              icon: const Icon(Icons.play_arrow_outlined),
              style: ElevatedButton.styleFrom(primary: Colors.greenAccent),
            ),
            const SizedBox(height: 36),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/widgets/background_gradient.dart';

import 'home_grid.dart';
import 'profile_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);
  final String title = "Home";

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BackgroundGradient2(
          child: Scaffold(
            resizeToAvoidBottomInset: false,
            backgroundColor: Colors.transparent,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              title: Text(title, style: const TextStyle(letterSpacing: 3)),
              centerTitle: true,
              elevation: 0,
              actions: [
                IconButton(
                    onPressed: () {
                      Get.toNamed("/settings");
                    },
                    icon: const Icon(Icons.settings))
              ],
            ),
            drawer: Drawer(
              elevation: 0,
              backgroundColor: Colors.purple.withOpacity(0.6),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  const Divider(),
                  TextButton(
                    child: const Text(
                      "Logout",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Get.toNamed("/");
                    },
                  ),
                ],
              ),
            ),
            body: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    label: const Text("Explore Services"),
                    icon: const Icon(Icons.search),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.pink,
                    ),
                    onPressed: () {
                      Get.toNamed("/search");
                    },
                  ),
                  const SizedBox(height: 24),
                  ProfileCard(),
                  const Divider(),
                  const HomeGrid(),
                  ElevatedButton.icon(
                    label: const Text("View Profile"),
                    icon: const Icon(Icons.person),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.orange,
                    ),
                    onPressed: () {
                      Get.toNamed("/profile");
                    },
                  ),
                  ElevatedButton.icon(
                    label: const Text("My Services"),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.amber,
                    ),
                    icon: const Icon(Icons.manage_accounts),
                    onPressed: () {
                      Get.toNamed("/myservices");
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

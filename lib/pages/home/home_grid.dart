import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeGrid extends StatelessWidget {
  const HomeGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(shrinkWrap: true, crossAxisCount: 3,
        // childAspectRatio:0.8,
        children: [
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/analytics");
                  },
                  child: const Icon(Icons.stacked_bar_chart)),
              const Text("Analytics"),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/favorites");
                  },
                  child: const Icon(Icons.favorite)),
              const Text("Favorites"),
            ],
          ),
          Column(
            children: [
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/history");
                  },
                  child: const Icon(Icons.my_library_books)),
              const Text("History"),
            ],
          ),
        ]);
  }
}

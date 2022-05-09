import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'manage_service_page.dart';

class ReviewsList extends GetView<ManageServiceController> {
  const ReviewsList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (controller.service.data() as Map).containsKey("reviews")
        ? ListView.separated(
            shrinkWrap: true,
            itemCount: controller.service["reviews"].length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final review = controller.service["reviews"][index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(review["reviewer"] ?? ""),
                      Text(review["message"] ?? ""),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(review["rating"].toStringAsFixed(1)),
                          RatingBarIndicator(
                            rating: review["rating"].toDouble(),
                            itemBuilder: (context, index) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            itemCount: 5,
                            itemSize: 20.0,
                            direction: Axis.horizontal,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          )
        : const Center(child: Text("No Reviews Yet"));
  }
}

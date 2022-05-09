import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/api_firestore.dart';
import 'package:kaamai/services/session.dart';

import 'service_info_page.dart';

void reviewDialog() {
  final api = Get.find<ApiService>();
  final reviewController = TextEditingController();
  final controller = Get.find<ServiceInfoController>();
  double myRating = 3;
  Get.defaultDialog(
      textConfirm: "Submit Review",
      onConfirm: () {
        final session = Get.find<Session>();

        Map review = {
          "reviewer": session.firebaseUser?.uid,
          "dateTime": DateTime.now(),
          "rating": myRating,
          "message": reviewController.text,
        };
        final Map data = controller.service.data() as Map;
        print(data);
        if (data.containsKey("reviews")) {
          data["reviews"].add(review);
        } else {
          data["reviews"] = [review];
        }
        print(data);
        api
            .postReview(controller.service.id, data)
            .then((_) => Get.find<ServiceInfoController>().getService());
        Get.back();
      },
      title: "Your Review",
      content: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                border: OutlineInputBorder(),
              ),
              controller: reviewController,
              maxLines: 3,
            ),
            const SizedBox(
              height: 12,
            ),
            RatingBar.builder(
              initialRating: myRating,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 4.0),
              itemBuilder: (context, _) => const Icon(
                Icons.star,
                color: Colors.amber,
              ),
              onRatingUpdate: (rating) {
                myRating = rating;
                print(myRating);
              },
            ),
          ],
        ),
      ));
}

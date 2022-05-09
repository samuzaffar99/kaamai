import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/api_firestore.dart';
import 'package:kaamai/services/session.dart';

//@todo use shared serviceController with extend
// class ServiceController extends GetxController{
//   final QueryDocumentSnapshot service = Get.arguments[0];
// }

//@todo add images
class ServiceTitleCard extends StatelessWidget {
  final DocumentSnapshot service;

  const ServiceTitleCard(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                const Spacer(),
                Text(
                  service["serviceName"],
                  textScaleFactor: 1.5,
                ),
                const Spacer(),
                FavoritesButton(service),
              ],
            ),
            Text(service["serviceType"]),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.star),
                Text(getRating()),
              ],
            )
          ],
        ),
      ),
    );
  }

  String getRating() {
    if ((service.data() as Map).containsKey("reviews") &&
        service["reviews"].length != 0) {
      double sum = service["reviews"].fold(0, (i, el) {
            return i + el['rating'];
          }) /
          (service["reviews"] as List).length;
      return sum.toStringAsFixed(1) + " (${service["reviews"].length} Reviews)";
    } else {
      return " No Reviews Yet";
    }
  }
}

//@todo move logic to controller, add ever worker, states
class FavoritesButton extends StatelessWidget {
  final api = Get.find<ApiService>();
  final DocumentSnapshot service;
  final session = Get.find<Session>();

  bool getIsFavorite() {
    return ((service.data() as Map).containsKey("favorites") &&
        (service["favorites"] as List).contains(session.firebaseUser?.uid));
  }

  Future<void> toggleFavorite() async {
    final Map data = service.data() as Map;
    if (data.containsKey("favorites")) {
      ((data["favorites"] as List).contains(session.firebaseUser?.uid))
          ? data["favorites"].remove(session.firebaseUser?.uid)
          : data["favorites"].add(session.firebaseUser?.uid);
    } else {
      data["favorites"] = [session.firebaseUser?.uid];
    }
    print(data);
    api.putService(service.id, data);
    isFavorite.value = !isFavorite.value;
  }

  final RxBool isFavorite = false.obs;

  FavoritesButton(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    isFavorite.value = getIsFavorite();
    return Obx(() => IconButton(
          onPressed: () async {
            await toggleFavorite();
          },
          icon: Icon(isFavorite.value ? Icons.favorite : Icons.favorite_border),
        ));
  }
}

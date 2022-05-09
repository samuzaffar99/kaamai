import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/api_firestore.dart';

import 'search_page.dart';

class ServicesList extends GetView<SearchController> {
  final ApiService api = Get.find<ApiService>();

  ServicesList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: api.getServices(),
      builder: (buildContext, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          throw snapshot.error!;
        } else if (!snapshot.hasData) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          print(snapshot.data);
          List docList = snapshot.data;
          return GetX<SearchController>(
            builder: (val) {
              //@todo optimize search?
              List filteredList = docList.where((e) {
                bool bool1 = e["serviceName"]
                    .toLowerCase()
                    .contains(controller.searchStringDeb.value);
                bool bool2 = false;
                if (e.data().containsKey("offers") &&
                    (e["offers"] as List).isNotEmpty) {
                  bool2 = (e["offers"] as List).any((map) {
                    return map["offerName"]
                        .toLowerCase()
                        .contains(controller.searchStringDeb.value);
                  });
                }
                return (bool1 || bool2);
              }).toList();
              print(filteredList);
              return ListView.separated(
                itemCount: filteredList.length,
                separatorBuilder: (context, index) => const Divider(),
                itemBuilder: (context, index) {
                  final service = filteredList[index];
                  return ServiceResultCard(service);
                },
              );
            },
          );
        }
      },
    );
  }
}

class ServiceResultCard extends StatelessWidget {
  final DocumentSnapshot service;

  const ServiceResultCard(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
        side: BorderSide(
          color: Colors.deepOrange.withOpacity(0.5),
          width: 1,
        ),
      ),
      // color: Colors.transparent,
      // elevation: 0,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 8,
            ),
            Text(
              service["serviceName"] ?? "",
              textScaleFactor: 1.2,
            ),
            Text(service["serviceType"] ?? ""),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: TextButton(
                        child: const Text("View Service"),
                        style: TextButton.styleFrom(
                            primary: Colors.deepOrangeAccent),
                        onPressed: () {
                          Get.toNamed("/serviceinfo", arguments: [service]);
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

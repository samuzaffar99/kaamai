import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/api_firestore.dart';
import 'package:kaamai/services/session.dart';

class ServicePage extends StatelessWidget {
  ServicePage({Key? key}) : super(key: key);

  final ApiService api = Get.find<ApiService>();
  final session = Get.find<Session>();
  final String title = "My Services";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(letterSpacing: 3)),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed("/addservice");
        },
        tooltip: "Add a new Service",
        child: const Icon(Icons.add),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Expanded(child: myServicesList()),
          ],
        ),
      ),
    );
  }

  Widget myServicesList() {
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
          final List docList = snapshot.data;
          docList.retainWhere((elem) => (elem.data().containsKey("ownerId") &&
              elem["ownerId"] == session.firebaseUser?.uid));
          print(docList);
          return ListView.separated(
            itemCount: docList.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final DocumentSnapshot service = docList[index];
              return ServiceCard(service);
            },
          );
        }
      },
    );
  }
}

class ServiceCard extends StatelessWidget {
  final DocumentSnapshot service;

  const ServiceCard(this.service, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Text(service["serviceName"] ?? ""),
            Text(service["serviceType"] ?? ""),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  const SizedBox(width: 12),
                  Expanded(
                    child: ElevatedButton(
                        child: const Text("Manage Service"),
                        style: ElevatedButton.styleFrom(
                            primary: Colors.greenAccent),
                        onPressed: () {
                          Get.toNamed("/manageservice", arguments: [service]);
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

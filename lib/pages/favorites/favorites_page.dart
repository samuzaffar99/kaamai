import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/pages/search/services_list.dart';
import 'package:kaamai/services/api_firestore.dart';
import 'package:kaamai/services/notifications.dart';
import 'package:kaamai/services/session.dart';

class FavoritesPage extends StatelessWidget {
  FavoritesPage({Key? key}) : super(key: key);

  final ApiService api = Get.find<ApiService>();

  final String title = "My Favorites";

  @override
  Widget build(BuildContext context) {
    callNotification();
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(letterSpacing: 3)),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: myServicesList(),
      ),
    );
  }

  Widget myServicesList() {
    final session = Get.find<Session>();
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
          List<QueryDocumentSnapshot> docList = snapshot.data;
          docList = docList.where((doc) {
            return ((doc.data() as Map).containsKey("favorites") &&
                (doc["favorites"] as List).contains(session.firebaseUser?.uid));
          }).toList();
          print(docList);
          return ListView.separated(
            itemCount: docList.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final DocumentSnapshot service = docList[index];
              return ServiceResultCard(service);
            },
          );
        }
      },
    );
  }
}

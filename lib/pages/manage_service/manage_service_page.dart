import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/pages/shared_components/service_title_card.dart';
import 'package:kaamai/pages/signup/service_forms.dart';
import 'package:kaamai/services/api_firestore.dart';

import 'offers_list.dart';
import 'reviews_list.dart';

class ManageServiceController extends GetxController {
  final DocumentSnapshot service = Get.arguments[0];
}

class ManageServiceBindings extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ManageServiceController());
  }
}

class ManageServicePage extends GetView<ManageServiceController> {
  ManageServicePage({Key? key}) : super(key: key);

  final ApiService api = Get.find<ApiService>();

  final String title = "Manage Service";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: const TextStyle(letterSpacing: 3)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            ServiceTitleCard(controller.service),
            // Divider(),
            const ServiceTabs(),
            // Expanded(child: OffersList()),
          ],
        ),
      ),
      floatingActionButton: const FloatingAddButton(),
    );
  }
}

//@todo fix serviceformcontroller not being removed, update state
class FloatingAddButton extends GetView<ManageServiceController> {
  const FloatingAddButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: () {
        final serviceFormController = Get.put(ServiceFormController());
        final api = Get.find<ApiService>();
        Get.defaultDialog(
            title: "Add an Offering",
            // backgroundColor: Colors.green,
            // titleStyle: const TextStyle(color: Colors.white),
            textConfirm: "Confirm",
            textCancel: "Cancel",
            buttonColor: Colors.pinkAccent,
            radius: 50,
            content: const Form3(),
            onConfirm: () {
              final Map data = controller.service.data() as Map;
              data["offers"].add(serviceFormController.offerForm.value);
              api.putService(controller.service.id, data);
              Get.back();
            });
      },
      tooltip: "Add an Offering",
      child: const Icon(Icons.add),
    );
  }
}

class ServiceTabs extends StatelessWidget {
  const ServiceTabs({Key? key}) : super(key: key);
  static const tabList = [
    Tab(icon: Icon(Icons.home_repair_service), text: "Services"),
    Tab(icon: Icon(Icons.reviews), text: "Reviews")
  ];

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: DefaultTabController(
          length: tabList.length,
          child: Column(
            children: const [
              TabBar(
                labelColor: Colors.pink,
                tabs: tabList,
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    OffersList(),
                    ReviewsList(),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}

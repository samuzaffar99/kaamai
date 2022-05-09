import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/session.dart';

import 'forms.dart';
import 'service_forms.dart';
import 'signup_page.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Form1(),
        const Spacer(),
        const ProceedButton(),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                  onPressed: () {
                    Get.snackbar("Account Registration Successful!", "Yay!");
                    Session session = Get.find<Session>();
                    session.createUser(
                        Get.find<SignupController>().detailsForm.value);
                  },
                  label: const Text("Complete"),
                  icon: const Icon(Icons.navigate_next)),
            ),
          ],
        ),
      ],
    );
  }
}

class ServiceDetailsPage extends StatelessWidget {
  const ServiceDetailsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Form2(),
        Spacer(),
        NextButton(),
      ],
    );
  }
}

class Offers extends GetView<ServiceFormController> {
  const Offers({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => ListView.separated(
            shrinkWrap: true,
            itemCount: controller.offersList.length,
            separatorBuilder: (context, index) => const Divider(),
            itemBuilder: (context, index) {
              final offer = controller.offersList[index];
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: <Widget>[
                      Text(offer["offerName"] ?? ""),
                      Text(offer["cost"] ?? ""),
                      Text(offer["description"] ?? ""),
                      // Text(offer["available"] ?? ""),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton(
                                  child: const Text("Remove"),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.redAccent),
                                  onPressed: () {
                                    controller.offersList.removeAt(index);
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
        Row(
          children: [
            Expanded(
              child: ElevatedButton.icon(
                  onPressed: () {
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
                          controller.offersList.add(controller.offerForm.value);
                          Get.back();
                        });
                  },
                  label: const Text("Add an Offering"),
                  icon: const Icon(Icons.add)),
            ),
          ],
        ),
      ],
    );
  }
}

class ServiceOffersPage extends StatelessWidget {
  const ServiceOffersPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        Offers(),
        Spacer(),
        FinishButton(),
      ],
    );
  }
}

class NextButton extends GetView<SignupController> {
  const NextButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
              onPressed: () {
                controller.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              label: const Text("Next"),
              icon: const Icon(Icons.navigate_next)),
        ),
      ],
    );
  }
}

class FinishButton extends GetView<SignupController> {
  const FinishButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
              onPressed: () {
                Get.snackbar("Account Registration Successful!", "Yay!");
                Session session = Get.find<Session>();
                Get.find<ServiceFormController>().postForm();
                session
                    .createUser(Get.find<SignupController>().detailsForm.value);
              },
              label: const Text("Create an Account"),
              icon: const Icon(Icons.check_circle)),
        ),
      ],
    );
  }
}

class ProceedButton extends GetView<SignupController> {
  const ProceedButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton.icon(
              onPressed: () {
                controller.pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn);
              },
              label: const Text("Proceed to Add Service"),
              icon: const Icon(Icons.arrow_forward)),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/api_firestore.dart';
import 'package:kaamai/services/session.dart';
import 'package:kaamai/widgets/background_wave.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import 'form_pages.dart';
import 'service_forms.dart';

class SignupController extends GetxController {
  final session = Get.find<Session>();
  final PageController pageController = PageController(initialPage: 0);
  final detailsForm = fb.group({
    "name": "Syeda Raheela Khan",
    "contactNum": "+923213210123",
    "cnic": "4210191111111",
  });

  @override
  void onInit() {
    super.onInit();
    detailsForm.patchValue({
      // "name": session.firebaseUser.displayName,
      "contactNum": session.firebaseUser?.phoneNumber,
    });
  }
}

class SignupBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => SignupController());
    Get.lazyPut(() => ServiceFormController());
  }
}

class SignupPage extends GetView<SignupController> {
  SignupPage({Key? key}) : super(key: key);

  final String title = "Sign Up";
  final ApiService api = Get.find<ApiService>();

  // creates a group
  // final form = fb.group({
  //   'name': 'John Doe',
  //   'email': ['', Validators.required, Validators.email],
  //   'password': Validators.required,
  // });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: const Icon(Icons.person),
        title: Text(title, style: const TextStyle(letterSpacing: 3)),
      ),
      body: Stack(
        children: [
          const Opacity(
            opacity: 0.6,
            child: BackgroundWave(),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SmoothPageIndicator(
                      controller: controller.pageController,
                      count: 3,
                      axisDirection: Axis.horizontal,
                      effect: const WormEffect(
                          dotHeight: 8,
                          dotColor: Colors.grey,
                          activeDotColor: Colors.pink),
                    ),
                  ),
                ),
                Expanded(
                  child: PageView(
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    controller: controller.pageController,
                    children: const <Widget>[
                      Center(
                        child: DetailsPage(),
                      ),
                      Center(
                        child: ServiceDetailsPage(),
                      ),
                      Center(
                        child: ServiceOffersPage(),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

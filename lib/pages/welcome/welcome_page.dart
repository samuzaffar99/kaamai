import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kaamai/services/phone_login.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../widgets/background_wave.dart';

class WelcomePage extends StatelessWidget {
  WelcomePage({Key? key}) : super(key: key);

  final PhoneLogin loginController = Get.put(PhoneLogin());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Opacity(
            opacity: 0.6,
            child: BackgroundWave(),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    const Icon(Icons.work, size: 100, color: Colors.red),
                    Text("Kaamai", style: Theme.of(context).textTheme.headline4),
                    const SizedBox(height: 16),
                    // const Image(
                    //   image: AssetImage('assets/logo2.png'),
                    //   width: 180,
                    // ),
                    // const Text('HerWork',
                    //     style: TextStyle(
                    //         fontSize: 36,
                    //         color: Colors.pinkAccent,
                    //         letterSpacing: 3)),
                    const SizedBox(height: 24),
                    TextField(
                      keyboardType: TextInputType.phone,
                      controller: loginController.phoneController,
                      decoration: const InputDecoration(
                        labelText: "Phone Number",
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: ElevatedButton(
                            onPressed: () {
                              loginController.verifyPhoneNumber();
                              inputOTP(context);
                            },
                            child: const Text("Send Verification Code"),
                          ),
                        ),
                      ],
                    ),
                    // Row(
                    //   children: [
                    //     Expanded(
                    //       child: ElevatedButton(
                    //         onPressed: () {
                    //           Get.toNamed("/signup");
                    //         },
                    //         child: const Text("Register"),
                    //       ),
                    //     ),
                    //   ],
                    // ),
                  ],
                ),
                const SizedBox(height: 20),
                // ElevatedButton(
                //   onPressed: () {
                //     Get.offAllNamed('/home');
                //   },
                //   child: const Text("Skip"),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future inputOTP(BuildContext context) {
    return Get.defaultDialog(
      title: "Enter OTP",
      content: Padding(
        padding: const EdgeInsets.all(4),
        child: PinCodeTextField(
          appContext: context,
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(5),
            fieldHeight: 50,
            fieldWidth: 40,
            activeFillColor: Colors.white,
          ),
          length: 6,
          obscureText: false,
          animationType: AnimationType.fade,
          animationDuration: const Duration(milliseconds: 300),
          // controller: loginController.codeController,
          onChanged: (_) {},
          onCompleted: (value) {
            loginController.codeController.text = value;
            Get.back();
            loginController.confirmCode();
          },
        ),
      ),
    );
  }
}

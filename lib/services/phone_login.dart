import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'session.dart';

class PhoneLogin extends GetxController {
  ConfirmationResult? webConfirmationResult;
  String? verificationId;
  final session = Get.find<Session>();

  final TextEditingController phoneController =
      TextEditingController(text: "+92");
  final TextEditingController codeController = TextEditingController();

  Future<void> verifyPhoneNumber() async {
    await (kIsWeb ? verifyWebPhoneNumber() : verifyPhoneNumberMobile());
  }

  Future<void> confirmCode() async {
    kIsWeb ? confirmCodeWeb() : confirmCodePhone();
  }

  Future<void> verifyWebPhoneNumber() async {
    ConfirmationResult confirmationResult =
        await session.firebaseAuth.signInWithPhoneNumber(phoneController.text);
    webConfirmationResult = confirmationResult;
  }

  Future<void> confirmCodeWeb() async {
    if (webConfirmationResult != null) {
      try {
        await webConfirmationResult!.confirm(codeController.text).then((value) {
          Get.snackbar("Success", 'Login Success');
          print(value);
          session.handleSignIn();
        });
      } catch (e) {
        Get.snackbar("Failure", 'Failed to sign in: ${e.toString()}');
      }
    } else {
      Get.snackbar("Failure",
          'Please input sms code received after verifying phone number');
    }
  }

  //verify phone number, with callback methods
  Future<void> verifyPhoneNumberMobile() async {
    try {
      print("trying to login");
      await session.firebaseAuth.verifyPhoneNumber(
        // phoneNumber: "+44 7444 555666",
        phoneNumber: phoneController.text,
        timeout: const Duration(seconds: 5),
        verificationCompleted: (PhoneAuthCredential phoneAuthCredential) async {
          print("verificationCompleted");
          await session.firebaseAuth.signInWithCredential(phoneAuthCredential);
          Get.snackbar("Success",
              'Phone number automatically verified and user signed in: $phoneAuthCredential');
        },
        verificationFailed: (FirebaseAuthException authException) {
          print("verificationFailed");
          Get.snackbar("Failure",
              "Phone number verification failed. Code: ${authException.code}. Message: ${authException.message}");
          if (authException.code == 'invalid-phone-number') {
            print('The provided phone number is not valid.');
          }
        },
        codeSent: (String verificationId, int? resendToken) async {
          print("codeSent");
          Get.snackbar("Code Sent",
              "Please check your phone for the verification code.");
          this.verificationId = verificationId;
          print(this.verificationId);
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          print("codeAutoRetrievalTimeout");
          // Get.snackbar("Code Timeout", "Resend Code");
          this.verificationId = verificationId;
        },
      );
    } catch (e) {
      Get.snackbar("Error", 'Failed to Verify Phone Number: $e');
    }
  }

  // sign in with phone.
  Future<void> confirmCodePhone() async {
    try {
      print("verification Id: ${verificationId!}");
      final PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verificationId!,
        // smsCode: "123456",
        smsCode: codeController.text,
      );
      session.firebaseUser =
          (await session.firebaseAuth.signInWithCredential(credential)).user!;
      Get.snackbar(
          "Success", 'Successfully signed in UID: ${session.firebaseUser?.uid}');
      session.handleSignIn();
    } catch (e) {
      print(e);
      Get.snackbar("Error", 'Failed to sign in');
    }
  }
}

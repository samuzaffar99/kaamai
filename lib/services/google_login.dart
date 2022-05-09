// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:get/get.dart';
// import 'package:google_sign_in/google_sign_in.dart';
//
// import 'session.dart';
//
// class GoogleLogin extends GetxController {
//   final GoogleSignIn _googleSignIn = GoogleSignIn();
//   final session = Get.find<Session>();
//
//   Future<void> signIn() async {
//     print("signIn");
//     GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
//     GoogleSignInAuthentication googleAuth = await googleUser!.authentication;
//
//     final AuthCredential _credential = GoogleAuthProvider.credential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     print("GoogleAuth Credentials done");
//     session.firebaseUser =
//         (await FirebaseAuth.instance.signInWithCredential(_credential)).user!;
//     session.handleSignIn();
//   }
// }

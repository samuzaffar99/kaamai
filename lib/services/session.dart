import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'api_firestore.dart';

class Session extends GetxService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  User? firebaseUser = FirebaseAuth.instance.currentUser;

  FirebaseFirestore db = FirebaseFirestore.instance;
  late DocumentReference userRef;
  late DocumentSnapshot userData;

  ApiService api = Get.find<ApiService>();

  RxBool isLoading = false.obs;
  RxBool isLoggedIn = false.obs;

  // void initState() {
    // isSignedIn();
  // }
  //
  // void isSignedIn() async {
  //   //read sharedprefs
  //   // isLoggedIn.value = await _googleSignIn.isSignedIn();
  //   if (isLoggedIn.value) {
  //     handleSignIn();
  //   }
  // }

  Future<void> handleSignIn() async {
    isLoading.value = true;
    try {
      bool existsUser = await initializeUser();
      Get.snackbar("Success", "Sign in success");
      isLoading.value = false;
      if (existsUser) {
        Get.offAllNamed('/home');
      } else {
        Get.toNamed('/signup');
      }
    } catch (err) {
      print(err);
      Get.snackbar("Error!", "Sign in fail");
      isLoading.value = false;
    }
  }

  Future<void> fetchUser() async {
    print("fetchUser");
    userRef = db.collection("users").doc(firebaseUser?.uid);
    userData = await api.getUser(firebaseUser!.uid);
  }

  Future<bool> initializeUser() async {
    print("initializeUser");
    await fetchUser();
    if (userData.exists) {
      print("UserData present on firestore");
      return true;
    } else {
      print("UserData not present on firestore");
      return false;
    }
    // print(userData.data());
    // Save Default Data to local preferences
    // await prefs.setString('id', firebaseUser.uid);
    // await prefs.setString('nickname', firebaseUser.displayName);
    // await prefs.setString('photoUrl', firebaseUser.photoURL);
    // print(UserData.data());
    // Load Data from Cloud to local preferences
    // await prefs.setString('id', UserData.get('id'));
    // await prefs.setString('nickname', UserData["nickname"]);
    // await prefs.setString('photoUrl', UserData[0].data()['photoUrl']);
    // await prefs.setString('aboutMe', UserData[0].data()['aboutMe']);
    // return existsUser;
  }

  Future<void> signOut() async {
    // await _googleSignIn.signOut();
    // await _googleSignIn.disconnect();
    await firebaseAuth.signOut();
  }

  //Create new user data using firebase uid
  Future<void> createUser(Map userData) async {
    await api.putUser(firebaseUser!.uid, userData);
    await handleSignIn();
  }

  //Create new user data using firebase uid
  Future<void> deleteUser() async {
    await api.delUser(firebaseUser!.uid);
    await firebaseAuth.signOut();
  }
}

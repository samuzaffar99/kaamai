import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/analytics_page.dart';
import 'pages/favorites/favorites_page.dart';
import 'pages/history_page.dart';
import 'pages/home/home_page.dart';
import 'pages/manage_service/manage_service_page.dart';
import 'pages/my_services/add_service.dart';
import 'pages/my_services/my_services.dart';
import 'pages/profile/profile_page.dart';
import 'pages/search/search_page.dart';
import 'pages/service_info/service_info_page.dart';
import 'pages/settings/settings_page.dart';
import 'pages/signup/signup_page.dart';
import 'pages/verification/verification_page.dart';
import 'pages/welcome/welcome_page.dart';
import 'services/api_firestore.dart';
import 'services/session.dart';

Future<void> main() async {
  await initializeServices();
  runApp(const MyApp());
}

Future<void> initializeServices() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Get.put(ApiService());
  Get.put(Session());
  // await Get.putAsync(() => ApiService().init());
  // await Get.putAsync(SettingsService()).init();
  return;
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kaaamai',
      initialRoute: '/',
      getPages: [
        // GetPage(
        //   name: '/main',
        //   page: () => const DashboardPage(),
        //   binding: NavBinding(),
        // ),
        GetPage(
          name: '/',
          page: () => WelcomePage(),
        ),
        GetPage(
          name: '/signup',
          page: () => SignupPage(),
          binding: SignupBinding(),
        ),
        GetPage(
          name: '/home',
          page: () => const HomePage(),
        ),
        GetPage(
          name: '/settings',
          page: () => SettingsPage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/history',
          page: () => HistoryPage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/analytics',
          page: () => AnalyticsPage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/profile',
          page: () => ProfilePage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/myservices',
          page: () => ServicePage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/serviceinfo',
          page: () => ServiceInfoPage(),
          binding: ServiceInfoBindings(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/manageservice',
          page: () => ManageServicePage(),
          binding: ManageServiceBindings(),
        ),
        // GetPage(name: '/admin', page: () => AdminPage()),
        GetPage(
          name: '/addservice',
          page: () => AddServicePage(),
          binding: AddServiceBinding(),
        ),
        GetPage(
          name: '/search',
          page: () => SearchPage(),
          transition: Transition.cupertino,
        ),
        GetPage(
          name: '/verify',
          page: () => const VerificationPage(),
          binding: VerificationBindings(),
        ),
        GetPage(
          name: '/favorites',
          page: () => FavoritesPage(),
        ),
      ],
      theme: ThemeData(
        primarySwatch: Colors.red,
        // textTheme: GoogleFonts.robotoTextTheme(
        //   Theme.of(context).textTheme,
        // ),
      ),
    );
  }
}

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'package:kibasi/auth/forgot_password_page.dart';
import 'package:kibasi/content/assets/views/asset_page.dart';
import 'package:kibasi/content/assets/views/edit_bus_page.dart';
import 'package:kibasi/content/assets/views/edit_driver_page.dart';
import 'package:kibasi/content/dashboard/dashboard_page.dart';
import 'package:kibasi/content/profile/profile_page.dart';
import 'package:kibasi/firebase_options.dart';
import 'package:kibasi/onboard/onboard_page.dart';
import 'package:kibasi/utils/firebase/fire_auth/fire_auth.dart';

import 'auth/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  User? user = FirebaseAuth.instance.currentUser;

  runApp(user != null
      ? RegisteredApp(
          user: user,
        )
      : MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kibasi Owner',
      debugShowCheckedModeBanner: false,
      home: LoginPage(),
    );
  }
}

class RegisteredApp extends StatelessWidget {
  User user;

  RegisteredApp({
    Key? key,
    required this.user,
  }) : super(key: key);

  // This widget is the root of the application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kibasi Owner',
      debugShowCheckedModeBanner: false,
      home: DashboardPage(user: user),
    );
  }
}

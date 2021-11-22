import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kibasi/content/dashboard/dashboard_page.dart';
import 'package:kibasi/content/profile/asset_page.dart';
import 'package:kibasi/content/profile/profile_page.dart';
import 'package:kibasi/onboard/onboard_page.dart';

import 'auth/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Kibasi Owner',
      debugShowCheckedModeBanner: false,
      home: AssetPage(
        assetID: 1,
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:kibasi/content/dashboard.dart';
import 'package:kibasi/content/dashboard/graph/graph_theme.dart';
import 'package:kibasi/onboard/onboard_page.dart';


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
      home: OnboardPage(),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kibasi/onboard/ui_view/slider_layout_view.dart';
import 'package:kibasi/utils/custom_color.dart' as color;


class OnboardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: color.AppColor.blue,
      body: onBordingBody(),
    );
  }

  Widget onBordingBody() => Container(
        child: SliderLayoutView(),
      );
}

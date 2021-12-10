import 'dart:math';

import 'package:flutter/material.dart';
import 'package:kibasi/widget/custom_clipper.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class CustomBezier extends StatelessWidget {
  const CustomBezier({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Transform.rotate(
        angle: -pi / 3,
        child: ClipPath(
          clipper: ClipPainter(),
          child: Container(
            height: MediaQuery.of(context).size.height * 0.5,
            width: MediaQuery.of(context).size.width,
            color: color.AppColor.blue,
          ),
        ),
      ),
    );
  }
}

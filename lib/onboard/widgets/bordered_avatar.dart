import 'package:flutter/material.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class BorderedAvatar extends StatelessWidget {
  final String url;
  final bool isText;
  final Color status;
  final double radius;

  BorderedAvatar(
      {Key? key,
      required this.url,
      required this.status,
      required this.radius,
      this.isText = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isText ? EdgeInsets.all(10) : EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: status,
        shape: BoxShape.circle,
      ),
      child: isText
          ? Text(
              url + '+',
              style: TextStyle(
                color: Colors.white,
                fontSize: radius,
              ),
            )
          : CircleAvatar(
              radius: radius,
              backgroundColor: color.AppColor.paleBlue,
              backgroundImage: AssetImage(url),
            ),
    );
  }
}

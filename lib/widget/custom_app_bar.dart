import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kibasi/utils/custom_color.dart' as color;

class CustomAppBar extends StatelessWidget {
  String? title;

  CustomAppBar({
    Key? key,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      child: Row(
        children: [
          InkWell(
            splashColor: color.AppColor.paleBlue,
            onTap: () {
              Get.back();
            },
            child: Icon(
              Icons.arrow_back_ios,
              size: 25,
              color: color.AppColor.paleBlue,
            ),
          ),
          Expanded(
            child: Center(
              child: Text(
                title!,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black38,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

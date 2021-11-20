import 'package:flutter/material.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class CustomList extends StatelessWidget {
  final String? title;
  final int? value, widgetID;
  final bool? isMoney;

  CustomList({this.title, this.value, this.widgetID, this.isMoney});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 130,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                isMoney == null
                    ? title!
                    : isMoney!
                        ? title! + " (Tshs)"
                        : title!,
                style: TextStyle(
                  fontSize: 12,
                  color: widgetID == 1 ? Colors.white70 : Colors.black38,
                  fontWeight: widgetID == 1 ? null : FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 5,
              ),
              Text(
                value.toString(),
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: widgetID == 1 ? Colors.white : Colors.black54,
                ),
              )
            ],
          ),
        ),
        Expanded(
          child: widgetID != null
              ? Container()
              : Icon(
                  Icons.brightness_1_rounded,
                  size: 10,
                  color: isMoney == null
                      ? color.AppColor.paleBlue
                      : isMoney!
                          ? color.AppColor.gold
                          : color.AppColor.label,
                ),
        ),
      ],
    );
  }
}

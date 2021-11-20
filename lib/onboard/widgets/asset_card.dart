import 'package:flutter/material.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class AssetCard extends StatelessWidget {
  final Color? colorCard;
  final int cardID;
  final Widget? widget;
  final double? height;
  final double? width;

  AssetCard(
      {Key? key,
      this.colorCard,
      this.cardID = 0,
      this.height = 160,
      this.width = 180,
      this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorCard,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
            color: color.AppColor.paleBlue.withOpacity(0.2),
            offset: Offset(3, 4),
            blurRadius: 20,
            spreadRadius: 1,
          ),
        ],
      ),
      child: widget,
    );
  }
}

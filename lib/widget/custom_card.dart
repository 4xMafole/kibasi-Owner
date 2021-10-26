import 'package:flutter/material.dart';
import 'package:kibasi/content/models/min_card_model.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class AppCard {
  Widget minCard(MinCardModel model) {
    return Container(
      padding: EdgeInsets.all(10),
      width: 115,
      height: 100,
      decoration: cardDecoration(),
      child: Column(
        children: [
          Text(
            model.title,
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 12,),
          ColorFiltered(
            colorFilter: ColorFilter.mode(color.AppColor.paleBlue, BlendMode.srcATop),
            child: Image(
              height: 50,
              width: 50,
              image: AssetImage(model.imageUrl),
            ),
          ),
          SizedBox(height: 10,),
          Text(
            "${model.number}",
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
          )
        ],
      ),
    );
  }

  BoxDecoration cardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(10),
      color: Colors.white,
      boxShadow: [
        BoxShadow(
          color: color.AppColor.paleBlue.withOpacity(0.14),
          offset: Offset(2, 4),
          spreadRadius: 3,
          blurRadius: 20,
        ),
        BoxShadow(
          color: color.AppColor.paleBlue.withOpacity(0.14),
          offset: Offset(-4, -2),
          spreadRadius: 3,
          blurRadius: 20,
        ),
      ],
    );
  }

}
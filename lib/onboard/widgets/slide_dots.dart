import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class SlideDots extends StatelessWidget {
  bool isActive;
  SlideDots(this.isActive);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: const EdgeInsets.symmetric(horizontal: 3.3),
      height: isActive ? 10 : 6,
      width: isActive ? 10 : 6,
      decoration: BoxDecoration(
        color: isActive ? color.AppColor.paleBlue : color.AppColor.altDeepBlue,
        border: isActive ?  Border.all(color: Colors.white,width: 2.0,) : Border.all(color: Colors.transparent,width: 1,),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
    );
  }
}

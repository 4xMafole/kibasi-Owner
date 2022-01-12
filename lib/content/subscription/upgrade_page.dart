import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kibasi/content/dashboard/dashboard_page.dart';
import 'package:kibasi/content/subscription/components.dart';
import 'package:kibasi/content/subscription/upgrade_page.dart';
import 'package:kibasi/widget/asset_card.dart';
import 'package:kibasi/widget/bordered_avatar.dart';
import 'package:kibasi/widget/custom_app_bar.dart';
import 'package:kibasi/utils/custom_color.dart' as color;
import 'package:rflutter_alert/rflutter_alert.dart';

class UpgradePage extends StatefulWidget {
  const UpgradePage({Key? key}) : super(key: key);

  @override
  _UpgradePageState createState() => _UpgradePageState();
}

class _UpgradePageState extends State<UpgradePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
        ),
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            CustomAppBar(title: "SUBSCRIPTION PLAN"),
            SizedBox(
              height: 10,
            ),
            _content(),
          ],
        ),
      ),
    );
  }

  Widget _content() {
    return Expanded(
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 15,
            ),
            AssetCard(
              colorCard: color.AppColor.label,
              width: 300,
              height: 65,
              widget: Text(
                'Unlock Unlimited Access',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            _profile(),
            SizedBox(
              height: 30,
            ),
            _instructions(),
            SizedBox(
              height: 30,
            ),
            _plans(),
            SizedBox(
              height: 30,
            ),
            // _termsAndPolicy(), Terms and conditions plus policy should be added here.
          ],
        ),
      ),
    );
  }

  _alert({required Color alertColor}) {
    Alert(
      context: context,
      image: BorderedAvatar(
        url: "assets/images/profile/profile.jpg",
        status: alertColor,
        radius: 50,
      ),
      title: "Success",
      style: AlertStyle(
        isButtonVisible: false,
        titleStyle: TextStyle(
          color: alertColor,
        ),
      ),
      content: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: 20,
              right: 8,
              left: 8,
              bottom: 20,
            ),
            child: Text(
              'Successfully unlocked the plan',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
          )
        ],
      ),
    ).show();
  }

  Widget _submitButton({required String text, required Color buttonColor}) {
    return GestureDetector(
      onTap: () {
        _alert(alertColor: buttonColor);
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: buttonColor.withOpacity(0.6),
                offset: Offset(2, 4),
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
            color: buttonColor),
        child: Text(
          text,
          style: TextStyle(
            fontSize: 20,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Widget _profile() {
    return BorderedAvatar(
      url: "assets/images/profile/profile.jpg",
      status: subCommponent.isPro!
          ? color.AppColor.blue
          : subCommponent.isPremium!
              ? color.AppColor.gold
              : color.AppColor.purple,
      radius: 30,
    );
  }

  Widget _instructions() {
    return _title(
      'Chooose one of the plan to continue enjoying our services within the app.',
    );
  }

  Widget _title(String title, {Color? textColor}) {
    return Text(
      title,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: textColor ?? color.AppColor.textBlack,
        fontSize: 18,
      ),
    );
  }

  Widget _plans() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _trialPlan(),
          SizedBox(
            width: 20,
          ),
          _proPlan(),
          SizedBox(
            width: 20,
          ),
          _premiumPlan(),
          SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _trialPlan() {
    return _planCard(
        buttonText: "Continue",
        title: "Trial",
        cost: "Free",
        planColor: color.AppColor.purple,
        content: Column(
          children: [
            _planListContent(
              text: "Analytics Dashboard",
              color: color.AppColor.purple,
            ),
            _planListContent(
              text: "2 Allowed Buses",
              color: color.AppColor.purple,
            ),
            _planListContent(
              text: "2 Allowed Drivers",
              color: color.AppColor.purple,
            ),
            _planListContent(
              text: "Allowed Advertisements",
              color: color.AppColor.purple,
            ),
          ],
        ));
  }

  Widget _proPlan() {
    return _planCard(
        buttonText: "Make Payment",
        title: "Pro",
        cost: "\$ 49.99 for 3 month",
        planColor: color.AppColor.blue,
        content: Column(
          children: [
            _planListContent(
              text: "Analytics Dashboard",
              color: color.AppColor.blue,
            ),
            _planListContent(
              text: "10 Allowed Buses",
              color: color.AppColor.blue,
            ),
            _planListContent(
              text: "15 Allowed Drivers",
              color: color.AppColor.blue,
            ),
            _planListContent(
              text: "No Advertisements",
              color: color.AppColor.blue,
            ),
            _planListContent(
              text: "Additional Analytics",
              color: color.AppColor.blue,
            ),
          ],
        ));
  }

  Widget _premiumPlan() {
    return _planCard(
        buttonText: "Make Payment",
        title: "Premium",
        cost: "\$ 159.99 / year",
        planColor: color.AppColor.gold,
        content: Column(
          children: [
            _planListContent(
              text: "Analytics Dashboard",
              color: color.AppColor.gold,
            ),
            _planListContent(
              text: "Unlimited Allowed Buses",
              color: color.AppColor.gold,
            ),
            _planListContent(
              text: "Unlimited Allowed Drivers",
              color: color.AppColor.gold,
            ),
            _planListContent(
              text: "No Advertisements",
              color: color.AppColor.gold,
            ),
            _planListContent(
              text: "Additional Analytics",
              color: color.AppColor.gold,
            ),
          ],
        ));
  }

  Widget _planCard(
      {required String title,
      required String buttonText,
      required String cost,
      Widget? content,
      Color? planColor}) {
    return AssetCard(
      colorCard: Colors.white,
      width: 270,
      height: 360,
      widget: Column(
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            cost,
            style: TextStyle(
              fontSize: 20,
              color: planColor,
            ),
          ),
          SizedBox(
            height: 15,
          ),
          content!,
          SizedBox(
            height: 30,
          ),
          Expanded(child: Container()),
          _submitButton(
            text: buttonText,
            buttonColor: planColor!,
          ),
        ],
      ),
    );
  }

  Widget _planListContent({required String text, Color? color}) {
    return SizedBox(
      height: 30,
      child: Row(
        children: [
          Icon(
            Icons.lens,
            size: 8,
            color: color,
          ),
          SizedBox(
            width: 10,
          ),
          _title(text),
        ],
      ),
    );
  }
}

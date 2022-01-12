import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kibasi/content/subscription/components.dart';
import 'package:kibasi/content/subscription/upgrade_page.dart';
import 'package:kibasi/widget/bordered_avatar.dart';
import 'package:kibasi/widget/custom_app_bar.dart';
import 'package:kibasi/utils/custom_color.dart' as color;
import 'package:rflutter_alert/rflutter_alert.dart';

class OwnerGatePage extends StatefulWidget {
  const OwnerGatePage({Key? key}) : super(key: key);

  @override
  _OwnerGatePageState createState() => _OwnerGatePageState();
}

class _OwnerGatePageState extends State<OwnerGatePage> {
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
            CustomAppBar(title: "OWNER GATE"),
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
            _profile(),
            SizedBox(
              height: 30,
            ),
            _instructions(),
            SizedBox(
              height: 30,
            ),
            _entryField("Password", isPassword: true),
            SizedBox(
              height: 30,
            ),
            _submitButton(),
          ],
        ),
      ),
    );
  }

  _alert() {
    Alert(
      context: context,
      image: BorderedAvatar(
        url: "assets/images/profile/profile.jpg",
        status: subCommponent.isPro!
            ? color.AppColor.blue
            : subCommponent.isPremium!
                ? color.AppColor.gold
                : color.AppColor.purple,
        radius: 50,
      ),
      title: "Wrong Key",
      style: AlertStyle(
        isCloseButton: false,
        titleStyle: TextStyle(
          color: color.AppColor.red,
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
              'The key is incorrect. Please try again.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.black38,
              ),
            ),
          )
        ],
      ),
      buttons: [
        DialogButton(
            color: color.AppColor.paleBlue,
            splashColor: color.AppColor.blue,
            radius: BorderRadius.circular(10),
            child: Text(
              'Try Again',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            onPressed: () {
              Get.back();
            }),
      ],
    ).show();
  }

  Widget _submitButton() {
    return GestureDetector(
      onTap: () {
        Get.to(const UpgradePage());
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                color: color.AppColor.paleBlue.withOpacity(0.6),
                offset: Offset(2, 4),
                blurRadius: 20,
                spreadRadius: 5,
              )
            ],
            color: color.AppColor.blue),
        child: Text(
          'Confirm Key',
          style: TextStyle(fontSize: 20, color: Colors.white),
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
      radius: 50,
    );
  }

  Widget _instructions() {
    return Text(
      'Gate verification key',
      style: TextStyle(
        fontSize: 20,
        color: color.AppColor.paleBlue,
      ),
    );
  }

  Widget _entryField(String title, {bool isPassword = false}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: color.AppColor.inputColor,
                  filled: true))
        ],
      ),
    );
  }
}

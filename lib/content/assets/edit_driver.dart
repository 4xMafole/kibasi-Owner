import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kibasi/auth/login_page.dart';
import 'package:kibasi/widget/bezier.dart';
import 'package:kibasi/utils/custom_color.dart' as color;
import 'package:kibasi/widget/bordered_avatar.dart';

class EditDriverPage extends StatefulWidget {
  const EditDriverPage({Key? key}) : super(key: key);

  @override
  _EditDriverPageState createState() => _EditDriverPageState();
}

class _EditDriverPageState extends State<EditDriverPage> {
  String initialValue = 'Select Bus';
  var _photo;
  ImagePicker picker = ImagePicker();

  _imgFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _photo = image!;
    });
  }

  var busList = [
    'Select Bus',
    'TAZ 1324',
    'DJA 0234',
    'REQ 3228',
    'JFO 3643',
    'OWE 3214',
    'REJ 7654',
    'DFG 2987'
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Container(
        child: Column(
          children: [
            SizedBox(
              height: 40,
            ),
            _appBar(),
            SizedBox(
              height: 10,
            ),
            Expanded(child: _content(height: height)),
          ],
        ),
      ),
    );
  }

  Widget _content({required double height}) {
    return Container(
      height: height,
      child: SingleChildScrollView(
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .25,
              right: -MediaQuery.of(context).size.width * .4,
              child: CustomBezier(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 16),
                  _title(),
                  SizedBox(
                    height: 50,
                  ),
                  _editDetailsWidget(),
                  SizedBox(
                    height: 10,
                  ),
                  _submitButton(),
                  SizedBox(height: height * 0.05),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title) {
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
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: color.AppColor.inputColor,
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return Container(
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
        'Add Driver',
        style: TextStyle(fontSize: 20, color: Colors.white),
      ),
    );
  }

  Widget _title() {
    return GestureDetector(
      onTap: () {
        _showPicker(context);
      },
      child: _photo != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(50),
              child: Image.file(
                File(_photo.path),
                width: 100,
                height: 100,
                fit: BoxFit.cover,
              ),
            )
          : BorderedAvatar(
              url: "assets/images/avatar.png",
              status: color.AppColor.paleBlue,
              radius: 50,
            ),
    );
  }

  Widget _editDetailsWidget() {
    return Column(
      children: <Widget>[
        _entryField("Driver's name"),
        SizedBox(
          height: 10,
        ),
        _dropDown("Given bus"),
      ],
    );
  }

  Widget _appBar() {
    return Padding(
      padding: const EdgeInsets.only(right: 16, left: 16),
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
                'ADD NEW DRIVER',
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

  Widget _dropDown(String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
        ),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10),
          margin: EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: color.AppColor.inputColor,
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton(
              isExpanded: true,
              iconEnabledColor: Colors.black,
              style: TextStyle(color: Colors.black, fontSize: 16),
              dropdownColor: color.AppColor.inputColor,
              focusColor: Colors.black,
              value: initialValue,
              icon: Icon(Icons.keyboard_arrow_down),
              items: busList.map((String items) {
                return DropdownMenuItem(value: items, child: Text(items));
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  initialValue = newValue!;
                });
              },
            ),
          ),
        ),
      ],
    );
  }

  void _showPicker(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(
                        Icons.photo_library,
                        color: color.AppColor.paleBlue,
                      ),
                      title: new Text(
                        'Photo Library',
                        style: TextStyle(
                          color: color.AppColor.paleBlue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                ],
              ),
            ),
          );
        });
  }
}

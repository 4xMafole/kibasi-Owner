import 'dart:io';

import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:kibasi/auth/login_page.dart';
import 'package:kibasi/widget/bezier.dart';
import 'package:kibasi/utils/custom_color.dart' as color;
import 'package:kibasi/widget/bordered_avatar.dart';
import 'package:kibasi/widget/time_entry_field.dart';

class EditBusPage extends StatefulWidget {
  const EditBusPage({Key? key}) : super(key: key);

  @override
  _EditBusPageState createState() => _EditBusPageState();
}

class _EditBusPageState extends State<EditBusPage> {
  var _photo;
  ImagePicker picker = ImagePicker();
  TextEditingController depTimeInput = TextEditingController();
  TextEditingController arrTimeInput = TextEditingController();

  _imgFromGallery() async {
    XFile? image = await picker.pickImage(source: ImageSource.gallery);

    setState(() {
      _photo = image!;
    });
  }

  @override
  void initState() {
    depTimeInput.text = "";
    arrTimeInput.text = "";
    super.initState();
  }

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

  Widget _entryField(String title, {bool? isNumber, bool? isCurrency}) {
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
                fillColor: Color(0xfff3f3f4),
                filled: true),
            keyboardType: isNumber == true || isCurrency == true
                ? TextInputType.number
                : null,
            inputFormatters: isNumber == true || isCurrency == true
                ? [
                    isNumber == true
                        ? FilteringTextInputFormatter.digitsOnly
                        : CurrencyTextInputFormatter(
                            decimalDigits: 0,
                            symbol: 'Tshs ',
                          )
                  ]
                : null,
          ),
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
        'Add Bus',
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
              url: "assets/images/bus_avatar.png",
              status: color.AppColor.paleBlue,
              radius: 50,
            ),
    );
  }

  Widget _editDetailsWidget() {
    return Column(
      children: <Widget>[
        _entryField("Bus name"),
        _entryField("Plate number"),
        _entryField("Number of seats", isNumber: true),
        _entryField("Price per seat", isCurrency: true),
        _entryField("From region"),
        _entryField("To region"),
        _entryField("Bus route"),
        TimeEntryField(title: "Departure time", textInput: depTimeInput),
        TimeEntryField(title: "Arrival time", textInput: arrTimeInput),
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
                'ADD NEW BUS',
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

  void _showTimePicker(context) {}
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kibasi/auth/login_page.dart';
import 'package:kibasi/auth/update_password_page.dart';
import 'package:kibasi/utils/firebase/fire_auth.dart';
import 'package:kibasi/utils/validator.dart';
import 'package:kibasi/widget/bezier.dart';
import 'package:kibasi/utils/custom_color.dart' as color;
import 'package:rflutter_alert/rflutter_alert.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  _ForgotPasswordPage createState() => _ForgotPasswordPage();
}

class _ForgotPasswordPage extends State<ForgotPasswordPage> {
  final _resetFormKey = GlobalKey<FormState>();
  final _emailNode = FocusNode();
  final _emailController = TextEditingController();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: CustomBezier(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Form(
                  key: _resetFormKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(height: height * .2),
                      _title(),
                      SizedBox(
                        height: 50,
                      ),
                      _subtitle(),
                      SizedBox(
                        height: 20,
                      ),
                      _normalText(),
                      SizedBox(
                        height: 40,
                      ),
                      _emailPasswordWidget(),
                      SizedBox(
                        height: 10,
                      ),
                      _submitButton(),
                      SizedBox(height: height * 0.05),
                      _loginAccountLabel(),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
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
          TextFormField(
              controller: _emailController,
              focusNode: _emailNode,
              obscureText: isPassword,
              validator: (value) => Validator.validateEmail(email: value!),
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true))
        ],
      ),
    );
  }

  Widget _submitButton() {
    return InkWell(
      onTap: () async {
        _emailNode.unfocus();

        if (_resetFormKey.currentState!.validate()) {
          setState(() {
            _isProcessing = true;
          });

          await FireAuth.resetPassword(
              context: context, email: _emailController.text);

          setState(() {
            _isProcessing = false;
          });

          Alert(
              context: context,
              type: AlertType.success,
              title: "SUCCESS",
              desc: "Check your email to reset your password",
              style: AlertStyle(
                isOverlayTapDismiss: false,
                isButtonVisible: false,
                titleStyle: TextStyle(
                  color: color.AppColor.green,
                ),
              ),
              closeFunction: () {
                Get.offAll(LoginPage());
              }).show();
        }
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
          'Reset Password',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "KIBASI",
        style: GoogleFonts.dosis(
          textStyle: Theme.of(context).textTheme.headline1,
          fontSize: 30,
          fontWeight: FontWeight.w700,
          color: color.AppColor.blue,
        ),
      ),
    );
  }

  Widget _subtitle() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Forgot Your Password?",
        style: GoogleFonts.dosis(
          textStyle: Theme.of(context).textTheme.headline1,
          fontSize: 20,
          fontWeight: FontWeight.w500,
          color: color.AppColor.blue,
        ),
      ),
    );
  }

  Widget _normalText() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
        text: "Enter email address associated with your account",
        style: GoogleFonts.dosis(
          textStyle: Theme.of(context).textTheme.headline1,
          fontSize: 16,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField("Email"),
      ],
    );
  }

  Widget _loginAccountLabel() {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      padding: EdgeInsets.all(15),
      alignment: Alignment.bottomCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Remember the password ?',
            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          SizedBox(
            width: 10,
          ),
          InkWell(
            onTap: () {
              Get.offAll(LoginPage());
            },
            child: Text(
              'Login',
              style: TextStyle(
                  color: color.AppColor.paleBlue,
                  fontSize: 13,
                  fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

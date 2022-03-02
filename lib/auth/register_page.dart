import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kibasi/auth/login_page.dart';
import 'package:kibasi/content/profile/profile_page.dart';
import 'package:kibasi/utils/firebase/fire_auth/fire_auth.dart';
import 'package:kibasi/utils/validator.dart';
import 'package:kibasi/widget/bezier.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class RegisterPage extends StatefulWidget {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _registerFormKey = GlobalKey<FormState>();

  final _nameNode = FocusNode();
  final _emailNode = FocusNode();
  final _passwordNode = FocusNode();
  final _confirmPasswordNode = FocusNode();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _conPasswordController = TextEditingController();

  bool _isProcessing = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: () {
        _nameNode.unfocus();
        _emailNode.unfocus();
        _passwordNode.unfocus();
        _confirmPasswordNode.unfocus();
      },
      child: Scaffold(
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
                    key: _registerFormKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        SizedBox(height: height * .2),
                        _title(),
                        SizedBox(
                          height: 50,
                        ),
                        _emailPasswordWidget(),
                        SizedBox(
                          height: 10,
                        ),
                        _isProcessing
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation<Color>(
                                  color.AppColor.blue,
                                ),
                              )
                            : _registerButton(),
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
      ),
    );
  }

  Widget _entryField(
    String title,
    TextEditingController textController,
    FocusNode focusField, {
    bool isPassword = false,
  }) {
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
            controller: textController,
            focusNode: focusField,
            obscureText: isPassword,
            validator: (value) => isPassword
                ? Validator.validatePassword(
                    password: _passwordController.text,
                    confirmPassword: _conPasswordController.text,
                  ) //confirm password should be checked
                : textController == _emailController
                    ? Validator.validateEmail(email: value!)
                    : Validator.validateName(title: title, name: value!),
            decoration: InputDecoration(
              border: InputBorder.none,
              fillColor: color.AppColor.inputColor,
              filled: true,
            ),
          ),
        ],
      ),
    );
  }

  Widget _registerButton() {
    return InkWell(
      onTap: () async {
        _nameNode.unfocus();
        _emailNode.unfocus();
        _passwordNode.unfocus();
        _confirmPasswordNode.unfocus();

        if (_registerFormKey.currentState!.validate()) {
          setState(() {
            _isProcessing = true;
          });

          User? user = await FireAuth.registerUsingEmailPassword(
            context: context,
            name: _nameController.text,
            email: _emailController.text,
            password: _passwordController.text,
          );

          setState(() {
            _isProcessing = false;
          });

          if (user != null) {
            Get.offAll(ProfilePage(
              user: user,
            ));
          }
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
          'Register',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),
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
            'Already have an account ?',
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

  Widget _emailPasswordWidget() {
    return Column(
      children: <Widget>[
        _entryField(
          "Username",
          _nameController,
          _nameNode,
        ),
        _entryField(
          "Email",
          _emailController,
          _emailNode,
        ),
        _entryField(
          "Password",
          _passwordController,
          _passwordNode,
          isPassword: true,
        ),
        _entryField(
          "Confirm Password",
          _conPasswordController,
          _confirmPasswordNode,
          isPassword: true,
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kibasi/content/dashboard/dashboard_page.dart';
import 'package:otp_screen/otp_screen.dart';
import 'package:kibasi/utils/custom_color.dart' as color;

class UpdatePasswordPage extends StatelessWidget {
  const UpdatePasswordPage({Key? key}) : super(key: key);

  Future<String?> validateOtp(String otp) async {
    await Future.delayed(Duration(milliseconds: 2000));
    if (otp == "123456") {
      return null;
    } else {
      return "The entered Otp is wrong";
    }
  }

  void moveToNextScreen(context) {
    Get.to(const DashboardPage());
  }

  @override
  Widget build(BuildContext context) {
    return OtpScreen.withGradientBackground(
      topColor: color.AppColor.blue,
      bottomColor: color.AppColor.paleBlue,
      otpLength: 6,
      validateOtp: validateOtp,
      routeCallback: moveToNextScreen,
      themeColor: Colors.white,
      titleColor: Colors.white,
      title: "Email Verification",
      subTitle: "Enter the code sent to \n john.doe@gmail.com",
    );
  }
}

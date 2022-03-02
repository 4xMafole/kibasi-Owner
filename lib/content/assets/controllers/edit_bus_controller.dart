import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:kibasi/content/assets/models/bus.dart';
import 'package:kibasi/content/assets/views/asset_page.dart';
import 'package:kibasi/utils/constants.dart';
import 'package:kibasi/utils/custom_color.dart';
import 'package:kibasi/utils/firebase/fire_auth/fire_auth.dart';
import 'package:kibasi/utils/firebase/firestore/database.dart';

class EditBusController extends GetxController {
  var newBusFormKey = GlobalKey<FormState>();

  final busNameController = TextEditingController();
  final plateNumberController = TextEditingController();
  final numberOfSeatsController = TextEditingController();
  final pricePerSeatController = TextEditingController();
  final fromRegionController = TextEditingController();
  final toRegionController = TextEditingController();
  final busRouteController = TextEditingController();
  final arrivalTimeController = TextEditingController();
  final departureTimeController = TextEditingController();

  final busNameNode = FocusNode();
  final plateNumberNode = FocusNode();
  final numberOfSeatsNode = FocusNode();
  final pricePerSeatNode = FocusNode();
  final fromRegionNode = FocusNode();
  final toRegionNode = FocusNode();
  final busRouteNode = FocusNode();
  final arrivalTimeNode = FocusNode();
  final departureTimeNode = FocusNode();

  RxBool isLoading = false.obs;
  RxBool isTimeEmpty = false.obs;

  void unFocusAll() {
    busNameNode.unfocus();
    plateNumberNode.unfocus();
    numberOfSeatsNode.unfocus();
    pricePerSeatNode.unfocus();
    fromRegionNode.unfocus();
    toRegionNode.unfocus();
    busRouteNode.unfocus();
    arrivalTimeNode.unfocus();
    departureTimeNode.unfocus();
  }

  void controllerDisposer() {
    busNameController.dispose();
    plateNumberController.dispose();
    numberOfSeatsController.dispose();
    pricePerSeatController.dispose();
    fromRegionController.dispose();
    toRegionController.dispose();
    busRouteController.dispose();
    arrivalTimeController.dispose();
    departureTimeController.dispose();
  }

  Future<void> submitData() async {
    unFocusAll();
    if (newBusFormKey.currentState!.validate()) {
      isLoading = true.obs;

      if (timeChecker() == true) {
        Get.snackbar(
          "JOURNEY TIME",
          "Please fill journey time fields",
          backgroundColor: AppColor.red.withOpacity(0.5),
          colorText: Colors.white,
        );
      } else {
        if (await DataConnectionChecker().hasConnection == true) {
          Database.addBusDetails(data: viewData());

          isLoading = false.obs;

          Get.back();
        } else {
          Get.snackbar(
            "NO CONNECTION",
            "Please turn on your internet!",
            backgroundColor: AppColor.red.withOpacity(0.5),
            colorText: Colors.white,
          );

          isLoading = false.obs;
        }
      }
    }
  }

  Bus viewData() {
    // print(currencyToInt(pricePerSeatController.text));
    return new Bus(
      busName: busNameController.text,
      plateNumber: plateNumberController.text,
      numberOfSeats: numberOfSeatsController.text,
      pricePerSeat: currencyToInt(pricePerSeatController.text),
      fromRegion: fromRegionController.text,
      toRegion: toRegionController.text,
      busRoute: busRouteController.text,
      departureTime: departureTimeController.text,
      arrivalTime: arrivalTimeController.text,
    );
  }

  RxBool timeChecker() {
    bool results = departureTimeController.text.isEmpty == true ||
        arrivalTimeController.text.isEmpty == true;
    return results.obs;
  }

  CurrencyTextInputFormatter formatCurrency() {
    return CurrencyTextInputFormatter(
      decimalDigits: 0,
      symbol: 'Tshs ',
    );
  }

  int currencyToInt(String currency) {
    var number = currency.replaceAll(new RegExp(r'[^0-9]'), '');

    return int.parse(number);
  }
}

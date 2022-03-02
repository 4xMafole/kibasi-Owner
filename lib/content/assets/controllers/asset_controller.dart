import 'package:data_connection_checker/data_connection_checker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kibasi/content/assets/models/bus.dart';
import 'package:kibasi/utils/custom_color.dart';
import 'package:kibasi/utils/firebase/firestore/database.dart';

class AssetController extends GetxController {
  late List<Bus>? busData = null;

  //TODO: make sure this returns a list of buses data
  Future<Stream<List<Bus>>?> displayBusData() async {
    if (await DataConnectionChecker().hasConnection == true) {
      var data = Database.readBusDetails()
          .map((event) => event.docs.map((e) => Bus.fromSnapshot(e)).toList());
      // var data = Database.readBusDetails().forEach((element) {
      //   element.docs.asMap().forEach((key, value) {
      //     busData = Bus.fromSnapshot(value);
      //     print(busData!.busName);
      //   });
      // });

      // data.forEach((element) {
      //   print(element.length);
      //   busData = element.obs;
      //   print(busData.obs);
      // });

      return data;
    } else {
      Get.snackbar(
        "NO CONNECTION",
        "Please turn on your internet!",
        backgroundColor: AppColor.red.withOpacity(0.5),
        colorText: Colors.white,
      );
    }

    print(busData.obs);
  }
}

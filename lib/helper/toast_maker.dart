import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';

class ToastMaker {
  showToast(String message) {
    Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  showSnackBar(String message) {
    Get.snackbar(message, message, snackPosition: SnackPosition.BOTTOM);
  }

  showSnackBarWithError(String message, error) {
    Get.snackbar(message, error.toString(),
        snackPosition: SnackPosition.BOTTOM);
  }
}

import 'dart:developer';

import 'package:e_commerce/helper/check_connection.dart';
import 'package:e_commerce/helper/local_storage_data.dart';
import 'package:e_commerce/data/model/user_model.dart';
import 'package:e_commerce/helper/toast_maker.dart';
import 'package:e_commerce/view/app/control_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileViewModel extends GetxController {
  final LocalStorageData localStorageData = Get.find();

  final ValueNotifier<bool> _loading = ValueNotifier(false);
  ValueNotifier<bool> get loading => _loading;

  UserModel _userModel = UserModel();
  UserModel get userModel => _userModel;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    getCurrentUser();
  }

  void getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    _loading.value = false;
    update();
  }

  signOut() async {
    if (await CheckConnection().isInternet()) {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      localStorageData.deleteUser();
      Get.offAll(() => ControlView());
    } else {
      ToastMaker().showSnackBar("No Internet Connection");
    }
  }
}

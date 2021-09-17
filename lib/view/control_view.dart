import 'package:e_commerce/core/view_model/auth_view_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'auth/login_view.dart';
import 'home_view.dart';

class ControlView extends GetWidget<AuthViewModel> {
  const ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user != null)
          ? HomeScreen()
          : LoginView();
    });
  }
}

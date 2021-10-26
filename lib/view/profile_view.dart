import 'package:e_commerce/core/view_model/profile_view_model.dart';
import 'package:e_commerce/view/auth/login_view.dart';
import 'package:e_commerce/view/control_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: ProfileViewModel(),
      builder: (controller) => Scaffold(
        body: Container(
          child: Center(
            child: TextButton(
              onPressed: () {
                controller.signOut();
                Get.offAll(() => const ControlView());
              },
              child: Text("Sign Out!"),
            ),
          ),
        ),
      ),
    );
  }
}

import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/core/view_model/profile_view_model.dart';
import 'package:e_commerce/view/app/profile/profile_view.dart';
import 'package:e_commerce/widgets/customs/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class SignOutAlertDialog extends StatelessWidget {
  const SignOutAlertDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: () {
          showDialog<String>(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: const CustomText(title: 'Sign Out of App?'),
              content: const Text(
                'Are you sure that you would like to sign out?',
              ),
              actions: <Widget>[
                TextButton(
                  onPressed: () => Get.back(),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  onPressed: () => Get.find<ProfileViewModel>().signOut(),
                  child: const Text('Sign Out'),
                ),
              ],
            ),
          );
        },
        icon: const Icon(
          Icons.logout,
          color: primaryColor,
        ));
  }
}

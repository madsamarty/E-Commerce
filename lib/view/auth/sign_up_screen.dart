import 'package:e_commerce/view/auth/welcom.dart';
import 'package:e_commerce/view/widgets/custom_flat_button.dart';
import 'package:e_commerce/view/widgets/custom_social_tap.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import '../../constance.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          leading: IconButton(
            color: Colors.black,
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              Get.back();
            },
          ),
        ),
        body: Center(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12),
            height: 480,
            decoration: BoxDecoration(boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 5,
                blurRadius: 7,
                offset: const Offset(0, 0),
              )
            ], color: Colors.white),
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              children: [
                const CustomText(
                  title: "Sign Up",
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextFromField(
                  title: "Name",
                  hint: "Mad Smarty",
                  onSave: () {},
                  validator: () {},
                ),
                CustomTextFromField(
                  title: "Email",
                  hint: "madsamarty@gmail.com",
                  onSave: () {},
                  validator: () {},
                ),
                CustomTextFromField(
                  title: "Password",
                  hint: "**************",
                  onSave: () {},
                  validator: () {},
                ),
                const SizedBox(
                  height: 30,
                ),
                CustomTextButton(
                  onPress: () {
                    //Get.to(() => WelcomePage());
                    //Get.toNamed("/Welcome");
                  },
                  title: "SIGN UP",
                ),
                TextButton(onPressed: (){
                  Get.toNamed("/Welcome");
                }, child: Text('Click')),

              ],
            ),
          ),
        ));
  }
}

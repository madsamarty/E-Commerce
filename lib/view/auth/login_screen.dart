import 'package:e_commerce/core/view_model/auth_view_model.dart';
import 'package:e_commerce/view/auth/sign_up_screen.dart';
import 'package:e_commerce/view/widgets/custom_flat_button.dart';
import 'package:e_commerce/view/widgets/custom_social_button.dart';
import 'package:e_commerce/view/widgets/custom_social_tap.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

import '../../constance.dart';

class LoginScreen extends GetWidget<AuthViewModel> {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        margin: const EdgeInsets.only(right: 12, left: 12, top: 100),
        child: Column(children: [
          Container(
            height: 370,
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
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const CustomText(
                      title: "Welcome,",
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                    ),
                    // Button
                    // Button
                    // Button
                    GestureDetector(
                      onTap: () {
                        //Get.to(() => SignupScreen());
                        Get.toNamed("/Signup");
                      },
                      child: const CustomText(
                        title: "SIGN UP",
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    )
                  ],
                ),
                const CustomText(
                    title: "Sign in to Continue",
                    fontSize: 12,
                    color: Colors.grey),
                const SizedBox(
                  height: 30,
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
                const CustomText(
                  title: "Forget Password",
                  fontSize: 14,
                  alignment: Alignment.centerRight,
                  deco: TextDecoration.underline,
                ),
                const SizedBox(
                  height: 20,
                ),
                // SignIn Button
                CustomTextButton(
                  onPress: () {},
                  title: "SIGN IN",
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 40,
          ),
          // -OR-
          const CustomText(
            title: "-OR-",
            alignment: Alignment.center,
            fontSize: 18,
          ),
          const SizedBox(
            height: 40,
          ),
          // Button
          TextButton(
              onPressed: () {
                //Get.toNamed('/Signup');
                controller.facebookSignInMethod();
              },
              style: TextButton.styleFrom(
                enableFeedback: false,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Image.asset("assets/images/facebook.png", scale: 1.2),
                    const Expanded(
                        child: CustomText(
                          title: "Sign In with Facebook",
                          fontSize: 12,
                          alignment: Alignment.center,
                        )),
                    const SizedBox(
                      width: 40,
                      height: 40,
                    )
                  ],
                ),
              )),

          const SizedBox(
            height: 20,
          ),
          TextButton(
              onPressed: () {
                //Get.toNamed('/Signup');
                controller.googleSignInMethod();
              },
              style: TextButton.styleFrom(
                enableFeedback: false,
              ),
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 15),
                child: Row(
                  children: [
                    Image.asset("assets/images/google.png", scale: 1.2),
                    const Expanded(
                        child: CustomText(
                      title: "Sign In with Google",
                      fontSize: 12,
                      alignment: Alignment.center,
                    )),
                    const SizedBox(
                      width: 40,
                      height: 40,
                    )
                  ],
                ),
              )),
        ]),
      ),
    );
  }
}

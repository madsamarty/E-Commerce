import 'package:e_commerce/core/view_model/auth_view_model.dart';
import 'package:e_commerce/view/auth/sign_up_screen.dart';
import 'package:e_commerce/view/widgets/custom_flat_button.dart';
import 'package:e_commerce/view/widgets/custom_social_button.dart';
import 'package:e_commerce/view/widgets/custom_social_tap.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

import '../../constance.dart';

class LoginScreen extends GetWidget<AuthViewModel> {
  LoginScreen({Key? key}) : super(key: key);

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();

  //Controller controller = Get.put(Controller());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      //resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(right: 20, left: 20, top: 50),
          child: FormBuilder(
            key: _globalKey,
            child: Column(children: [
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
                onSave: () {},
                validator: () {},
                name: "email",
                title: "Email",
                hint: "madsamarty@gmail.com",
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFromField(
                onSave: () {},
                validator: () {},
                name: "pass",
                title: "Password",
                hint: "********",
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomText(
                title: "Forget Password",
                fontSize: 14,
                alignment: Alignment.centerRight,
              ),
              const SizedBox(
                height: 20,
              ),
              // SignIn Button
              CustomTextButton(
                onPress: () {
                  controller.signInWithEmailAndPassword();
                },
                title: "SIGN IN",
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
              CustomSocialButton(
                onPress: () {
                  controller.facebookSignInMethod();
                },
                title: "Sign In with Facebook",
                icon: "assets/images/facebook.png",
              ),
              const SizedBox(
                height: 20,
              ),
              CustomSocialButton(
                onPress: () {
                  controller.googleSignInMethod();
                },
                title: "Sign In with Google",
                icon: "assets/images/google.png",
              )
            ]),
          ),
        ),
      ),
    );
  }
}

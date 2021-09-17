import 'package:e_commerce/core/view_model/auth_view_model.dart';
import 'package:e_commerce/view/widgets/custom_flat_button.dart';
import 'package:e_commerce/view/widgets/custom_social_tap.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/custom_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';

import '../../constance.dart';

class RegisterView extends GetWidget<AuthViewModel> {
  RegisterView({Key? key}) : super(key: key);

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //resizeToAvoidBottomInset: false,
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
          child: SingleChildScrollView(
            child: Form(
              key: _formKey,
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
                  const CustomText(
                    title: "Name",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  CustomTextFromField(
                    controller: controller.nameController,
                    title: "Name",
                    hint: "Abcde Fghij",
                    onSave: (value) {
                      controller.name = value!;
                    },
                    validator: (value) {},
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const CustomText(
                    title: "Email",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  CustomTextFromField(
                    controller: controller.emailController,
                    txtInType: TextInputType.emailAddress,
                    title: "Email",
                    hint: "example@gmail.com",
                    onSave: (value) {
                      controller.email = value!;
                    },
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email is required";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const CustomText(
                    title: "Password",
                    fontSize: 12,
                    color: Colors.black,
                  ),
                  CustomTextFromField(
                    controller: controller.passwordController,
                    txtInType: TextInputType.visiblePassword,
                    obscure: true,
                    title: "Name",
                    hint: "***********",
                    onSave: (String? value) {
                      controller.password = value!;
                    },
                    validator: (value) {
                      return controller.validatePassword(value!);
                    },
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CustomTextButton(
                    onPress: () {
                      _formKey.currentState!.save();

                      if (_formKey.currentState!.validate()) {
                        controller.createAccountWithEmailAndPassword();
                      }
                    },
                    title: "SIGN UP",
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

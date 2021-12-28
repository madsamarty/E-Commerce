import 'package:e_commerce/view/widgets/customs/custom_text.dart';
import 'package:e_commerce/view/widgets/customs/custom_text_from_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddAddress extends StatelessWidget {
  const AddAddress({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset("assets/icons/check.png"),
                        const CustomText(
                            title:
                                "Billing address is the same as delivery address")
                      ],
                    ),
                  ),
                  CustomTextFromField(
                    onSave: (save) {},
                    validator: (validator) {},
                    controller: null,
                    title: "Street 1",
                  ),
                  CustomTextFromField(
                    onSave: (save) {},
                    validator: (validator) {},
                    controller: null,
                    title: "Street 2",
                  ),
                  CustomTextFromField(
                    onSave: (save) {},
                    validator: (validator) {},
                    controller: null,
                    title: "City",
                  ),
                  SizedBox(
                    width: Get.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: CustomTextFromField(
                            onSave: (save) {},
                            validator: (validator) {},
                            controller: null,
                            title: "State",
                          ),
                        ),
                        const SizedBox(
                          width: 30,
                        ),
                        Expanded(
                          child: CustomTextFromField(
                            onSave: (save) {},
                            validator: (validator) {},
                            controller: null,
                            title: "Country",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              )),
        ],
      ),
    );
  }
}

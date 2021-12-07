import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';
import 'package:e_commerce/view/widgets/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'custom_text.dart';

class CustomBottomAppBar extends StatelessWidget {
  final String title;
  final String price;

  final String btntitle;
  final Function onPressed;

  const CustomBottomAppBar(
      {Key? key,
      this.price = "000",
      required this.title,
      required this.btntitle,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      elevation: 10,
      child: Container(
        height: 80,
        width: double.maxFinite,
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  title: title,
                  color: Colors.grey,
                ),
                const SizedBox(
                  height: 3,
                ),
                GetBuilder<CartViewModel>(
                    init: Get.find<CartViewModel>(),
                    builder: (controller) => CustomText(
                          title: price + " \$",
                          fontSize: 20,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        )),
              ],
            ),
            SizedBox(
                width: 130,
                child: CustomTextButton(
                  onPress: () {
                    onPressed();
                  },
                  title: btntitle,
                )),
          ],
        ),
      ),
    );
  }
}

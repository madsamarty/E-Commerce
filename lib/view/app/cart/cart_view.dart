import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';
import 'package:e_commerce/view/checkout/main_checkout_view.dart';
import 'package:e_commerce/view/widgets/custom_flat_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (controller) => controller.cartList.isEmpty
            ? StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection("collectionPath")
                    .snapshots(),
                builder: (context, snapshot) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SvgPicture.asset(
                          "assets/images/empty_cart.svg",
                          width: 200,
                          height: 200,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        const CustomText(
                          title: "Cart Empty",
                          fontSize: 18,
                          alignment: Alignment.center,
                        )
                      ],
                    ),
                  );
                })
            : Column(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          const EdgeInsets.only(top: 10, right: 10, left: 10),
                      child: ListView.separated(
                        itemCount: controller.cartList.length,
                        itemBuilder: (context, index) {
                          final item = controller.cartList[index];
                          return Dismissible(
                            key: ObjectKey(item),
                            onDismissed: (direction) {
                              controller
                                  .deleteProduct(controller.cartList[index]);
                            },
                            child: Container(
                              height: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: [
                                  SizedBox(
                                      height: 130,
                                      width: 130,
                                      child: Image.network(
                                        controller.cartList[index].image
                                            .toString(),
                                        fit: BoxFit.fill,
                                      )),
                                  Expanded(
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 15, vertical: 20),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            title: controller
                                                .cartList[index].name
                                                .toString(),
                                            fontSize: 18,
                                          ),
                                          CustomText(
                                            title: controller
                                                    .cartList[index].price
                                                    .toString() +
                                                "\$",
                                            color: primaryColor,
                                            fontSize: 18,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Container(
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(5),
                                              color: Colors.grey.shade200,
                                            ),
                                            height: 30,
                                            width: 120,
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),

                                            //width: double.maxFinite / 3,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                GestureDetector(
                                                  onTap: () => controller
                                                      .increaseQuantity(index),
                                                  child: Container(
                                                      //padding: const EdgeInsets.only(bottom: 20),
                                                      child: const Icon(
                                                          Icons.add)),
                                                ),
                                                const VerticalDivider(),
                                                CustomText(
                                                  title: controller
                                                      .cartList[index].quantity
                                                      .toString(),
                                                  alignment: Alignment.center,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                const VerticalDivider(),
                                                GestureDetector(
                                                  onTap: () => controller
                                                      .decreaseQuantity(index),
                                                  child: Container(
                                                      child: const Icon(
                                                          Icons.minimize)),
                                                )
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) {
                          return const SizedBox(
                            height: 10,
                          );
                        },
                      ),
                    ),
                  ),
                  Container(
                    height: 80,
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 25),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const CustomText(
                              title: "TOTAL",
                              color: Colors.grey,
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            CustomText(
                              title: controller.totalPrice.toString() + " \$",
                              fontSize: 20,
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                          ],
                        ),
                        SizedBox(
                            width: 130,
                            child: CustomTextButton(
                              onPress: () {
                                // controller.getAllProduct();
                                Get.to(() => MainCheckOutView());
                              },
                              title: "Check Out",
                            )),
                      ],
                    ),
                  ),
                ],
              ),
      ),
      /* bottomNavigationBar: GetBuilder<CartViewModel>(
          init: CartViewModel(),
          builder: (controller) => BottomAppBar(
            elevation: 10,
            child: 
          ),
        ) */
    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/constance.dart';
import 'package:e_commerce/view_model/cart_view_model.dart';
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
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (controller) => controller.cartItemList.isEmpty
            ? SmartRefresher(
                controller: controller.refreshController,
                onRefresh: controller.onRefresh,
                child: Container(
                  color: backgroundColor,
                  child: Center(
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
                  ),
                ),
              )
            : Container(
                color: backgroundColor,
                child: Column(
                  children: [
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(top: 10),
                        child: ListView.separated(
                          itemCount: controller.cartProductList.length,
                          itemBuilder: (context, index) {
                            final item = controller.cartProductList[index];
                            return Dismissible(
                              key: UniqueKey(),
                              onDismissed: (direction) {
                                controller.deleteProductFromCart(controller
                                    .cartProductList[index].productId!);
                              },
                              child: Container(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 15),
                                height: 150,
                                decoration: const BoxDecoration(
                                  color: Colors.white,
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                        height: 130,
                                        width: 130,
                                        child: AspectRatio(
                                          aspectRatio: 4 / 3,
                                          child: Image.network(
                                            controller
                                                .cartProductList[index].image
                                                .toString(),
                                            fit: BoxFit.scaleDown,
                                          ),
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
                                                  .cartProductList[index].name
                                                  .toString(),
                                              fontSize: 18,
                                            ),
                                            CustomText(
                                              title: controller
                                                      .cartProductList[index]
                                                      .price
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
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 10),

                                                //width: double.maxFinite / 3,
                                                child: quantityMenu(index))
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

  Widget quantityMenu(int i) {
    String? dropdownValue = "1";

    return GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (controller) {
          return DropdownButton<String>(
            value: dropdownValue,
            iconSize: 24,
            items: <String>['1', '2', '3', '4']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (value) {
              /* dropdownValue = value;
              controller.changeQuantity(value, i); */
            },
          );
        });
  }
}

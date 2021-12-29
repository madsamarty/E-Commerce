import 'package:e_commerce/constants/constance.dart';
import 'package:e_commerce/view/app/product_details/details_view.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';
import 'package:e_commerce/view/app/cart/checkout/main_checkout_view.dart';
import 'package:e_commerce/view/widgets/customs/custom_flat_button.dart';
import 'package:e_commerce/view/widgets/customs/custom_text.dart';
import 'package:e_commerce/view/widgets/productsShowingStyles/cart_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class CartView extends StatelessWidget {
  const CartView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (controller) => controller.cartProductList.isEmpty
            ? SmartRefresher(
                controller: controller.refreshController,
                //onRefresh: controller.onRefresh,
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
                        margin: const EdgeInsets.only(top: 5),
                        child: ListView.separated(
                          itemCount: controller.cartProductList.length,
                          itemBuilder: (context, index) {
                            return CartProductWidget(
                                onDismissed: () {
                                  controller.deleteProductFromCart(controller
                                      .cartProductList[index].productId!);
                                },
                                onTap: () {
                                  Get.to(() => DetailsView(
                                        model:
                                            controller.cartProductList[index],
                                      ));
                                },
                                onChanged: (newValue) {
                                  controller.changeQuan(
                                      /* controller
                                          .cartProductList[index].productId
                                          .toString(), */
                                      newValue);
                                },
                                imageUrl: controller
                                    .cartProductList[index].image
                                    .toString(),
                                title: controller.cartProductList[index].name
                                    .toString(),
                                price: controller.cartProductList[index].price
                                    .toString(),
                                quantity:
                                    controller.cartProductList[index].quantity!,
                                index: index);
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 5,
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
                                fontSize: 12,
                              ),
                              const SizedBox(
                                height: 3,
                              ),
                              CustomText(
                                title:
                                    controller.totalPrice.toString() + " EGP",
                                fontSize: 18,
                                color: primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ],
                          ),
                          SizedBox(
                              width: 130,
                              child: CustomTextButton(
                                backgroundColor: primaryColor,
                                onPress: () {
                                  // controller.getAllProduct();
                                  //Get.to(() => MainCheckOutView());
                                  CartViewModel();
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
}

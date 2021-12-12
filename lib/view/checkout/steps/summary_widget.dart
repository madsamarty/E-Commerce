import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';
import 'package:e_commerce/core/view_model/checkout_view_model.dart';
import 'package:e_commerce/view/app/home/details_view.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class Summary extends StatelessWidget {
  const Summary({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (controller) => Expanded(
              child: Container(
                padding: const EdgeInsets.all(20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      height: 200,
                      child: ListView.separated(
                        itemCount: controller.cartList.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Colors.grey.shade100,
                                  /* boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: const Offset(10, 10),
                        blurRadius: 7)
                  ] */
                                ),
                                child: SizedBox(
                                    //height: 240,
                                    width:
                                        MediaQuery.of(context).size.width * .4,
                                    child: Image.network(
                                      controller.cartList[index].image!,
                                      fit: BoxFit.cover,
                                    )),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomText(
                                fontSize: 18,
                                title: controller.cartList[index].name!,
                                alignment: Alignment.bottomLeft,
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              CustomText(
                                fontSize: 18,
                                title: controller.cartList[index].price,
                                color: primaryColor,
                                alignment: Alignment.bottomLeft,
                              ),
                            ],
                          );
                        },
                        separatorBuilder: (BuildContext context, int index) =>
                            const SizedBox(
                          width: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ));
  }

  /* Widget _listViewProducts() {
    return GetBuilder<CartViewModel>(
      init: Get.find<CartViewModel>(),
      builder: (controller) => SizedBox(
        height: 220,
        child: ListView.separated(
          itemCount: controller.cartList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ProductWidget(
                onTap: () {
                  Get.to(() => DetailsView(model: controller.cartList[index]));
                },
                image: controller.productModelList[index].image,
                title: controller.productModelList[index].name.toString(),
                dis: controller.productModelList[index].dis.toString(),
                price: controller.productModelList[index].price.toString() +
                    " \$");
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 20,
          ),
        ),
      ),
    );
  } */
}

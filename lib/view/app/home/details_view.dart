import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';
import 'package:e_commerce/model/cart_product_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/widgets/custom_bottom_bar.dart';
import 'package:e_commerce/view/widgets/custom_choice_button.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class DetailsView extends StatelessWidget {
  final ProductModel model;
  const DetailsView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Column(
          children: [
            Stack(
              children: [
                SafeArea(
                  child: Container(
                      padding: const EdgeInsets.all(20),
                      width: MediaQuery.of(context).size.width,
                      //height: 270,
                      child: Image.network(model.image!, fit: BoxFit.cover)),
                ),
                Container(
                  padding: const EdgeInsets.only(top: 20, right: 10),
                  child: AppBar(
                    foregroundColor: Colors.black,
                    actions: [
                      IconButton(
                          onPressed: () {},
                          icon: const Icon(
                            Icons.favorite_outline,
                            color: primaryColor,
                          ))
                    ],
                    backgroundColor: Colors.transparent,
                    elevation: 0.0,
                  ),
                )
              ],
            ),
            Expanded(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Container(
                  padding: const EdgeInsets.only(
                      top: 17, left: 10, right: 10, bottom: 10),
                  child: Column(
                    children: [
                      CustomText(
                        title: model.name.toString(),
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      /* SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CustomChoiceButton(
                              option: CustomText(
                                title: model.size.toString(),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            CustomChoiceButton(
                                option: Container(
                              width: 20,
                              height: 20,
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(3),
                                color: model.color,
                              ),
                            )),
                          ],
                        ),
                      ), */
                      const CustomText(
                        title: "Details",
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      CustomText(
                        title: model.dis.toString(),
                        height: 1.5,
                        maxLine: 100,
                      ),
                      CustomText(
                        title: model.dis.toString(),
                        height: 1.5,
                        maxLine: 100,
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
        bottomNavigationBar: GetBuilder<CartViewModel>(
          init: Get.find<CartViewModel>(),
          builder: (controller) => CustomBottomAppBar(
              title: "Price",
              price: model.price.toString(),
              btntitle: "ADD",
              onPressed: () => controller.addProduct(CartProductModel(
                  productId: model.productId,
                  userId: controller.userID,
                  name: model.name,
                  image: model.image,
                  price: model.price,
                  quantity: 1))),
        ));
  }

  /* Widget _listPhotosPrev() {
    return (Get.find<CartViewModel>().adModel.isEmpty)
        ? Container()
        : GetBuilder<CartViewModel>(
            init: Get.find<HomeViewModel>(),
            builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: CarouselSlider.builder(
                  carouselController: buttonCarouselController,
                  itemCount: controller.adModel.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return AdWidget(url: controller.adModel[itemIndex].image);
                  },
                  options: CarouselOptions(
                    autoPlay: true,
                    enlargeCenterPage: true,
                    viewportFraction: 1,
                    aspectRatio: 2.0,
                    initialPage: 2,
                  )),
            ),
          );
  } */
}

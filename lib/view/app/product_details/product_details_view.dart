import 'package:e_commerce/constance.dart';
import 'package:e_commerce/data/model/cart_item_model.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/core/view_model/profile_view_model.dart';
import 'package:e_commerce/core/view_model/wishlist_view_model.dart';
import 'package:e_commerce/view/widgets/customs/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import '../../../globals.dart';

class DetailsView extends StatelessWidget {
  final ProductModel model;
  DetailsView({Key? key, required this.model}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Stack(
            children: [
              SafeArea(
                child: Container(
                    color: Colors.white,
                    padding: const EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width,
                    child: AspectRatio(
                        aspectRatio: 4 / 3,
                        child: Image.network(model.image!,
                            fit: BoxFit.scaleDown))),
              ),
              Container(
                padding: const EdgeInsets.only(top: 20, right: 10),
                child: AppBar(
                  foregroundColor: Colors.black,
                  actions: [
                    GetBuilder<WishlistViewModel>(
                        init: Get.find<WishlistViewModel>(),
                        builder: (controller) {
                          return PopupMenuButton<String>(
                            itemBuilder: (BuildContext context) =>
                                <PopupMenuEntry<String>>[
                              const PopupMenuItem<String>(
                                value: 'wihslist',
                                child: Text('Add to wishlist'),
                              ),
                              const PopupMenuItem<String>(
                                value: 'report',
                                child: Text('Report item'),
                              ),
                            ],
                            onSelected: (String result) {
                              /* switch (result) {
                                case 'wihslist':
                                  controller.addProductToWishlist(
                                      UserRelatedItemModel(
                                          userId: Get.find<HomeViewModel>()
                                              .userModel
                                              .userId,
                                          productId: model.productId.toString(),
                                          quantity: 1));
                                  controller.getWishlistProducts();

                                  break;
                                case 'option2':
                                  print('option 2 clicked');
                                  break;
                                case 'delete':
                                  print('I want to delete');
                                  break;
                                default:
                              } */
                            },
                          );
                        })
                  ],
                  backgroundColor: Colors.transparent,
                  elevation: 0.0,
                ),
              ),
            ],
          ),
          Expanded(
            child: Stack(
              //alignment: Alignment.bottomCenter,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Container(
                      margin: const EdgeInsets.all(10),
                      padding: const EdgeInsets.only(
                          top: 17, left: 10, right: 10, bottom: 10),
                      child: Column(
                        children: [
                          CustomText(
                            title: model.name.toString(),
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
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
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Positioned(
                  child: bottomBar(),
                  bottom: 0,
                  right: 0,
                  left: 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget bottomBar() {
    return GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (controller) {
          return Container(
            height: 50,
            margin: const EdgeInsets.only(right: 20, left: 20, bottom: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(50),
                color: backgroundColor),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    onTap: () {
                      controller.addProduct(ProductModel(
                        userId: controller.userModel.userId,
                        productId: model.productId,
                        name: model.name,
                        image: model.image,
                        dis: model.dis,
                        category: model.category,
                        price: model.price,
                        quantity: 1,
                      ));
                    },
                    child: Expanded(
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: const CustomText(
                          title: 'Add To Cart',
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          alignment: Alignment.center,
                        ),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: GestureDetector(
                    child: Container(
                      decoration: const BoxDecoration(
                          color: primaryColor,
                          borderRadius: BorderRadiusDirectional.only(
                            bottomEnd: Radius.circular(50),
                            topEnd: Radius.circular(50),
                          )),
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: const CustomText(
                        title: 'Buy Now',
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        alignment: Alignment.center,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
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

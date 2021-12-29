import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/constants/constance.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';

import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/view/widgets/customs/custom_text.dart';

class DetailsView extends StatelessWidget {
  final ProductModel model;

  const DetailsView({
    Key? key,
    required this.model,
  }) : super(key: key);

  //get primaryColor => null;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SafeArea(
              child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Stack(
              children: [
                Column(
                  children: [
                    Stack(
                      children: [
                        CarouselSlider(
                            items: [model.image.toString()].map((e) {
                              return GetBuilder<HomeViewModel>(
                                builder: (controller) {
                                  return Container(
                                      width: MediaQuery.of(context).size.width,
                                      padding: const EdgeInsets.all(10),
                                      color: Colors.white,
                                      //margin: const EdgeInsets.symmetric(horizontal: 5.0),
                                      //decoration: BoxDecoration(color: Colors.amber),
                                      child: Image.network(
                                        e,
                                        fit: BoxFit.scaleDown,
                                      ));
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              aspectRatio: 4 / 3,
                              viewportFraction: 1,
                              initialPage: 0,
                              enableInfiniteScroll: true,
                              reverse: false,
                              autoPlay: true,
                              autoPlayInterval: const Duration(seconds: 3),
                              autoPlayAnimationDuration:
                                  const Duration(milliseconds: 800),
                              autoPlayCurve: Curves.fastOutSlowIn,
                              enlargeCenterPage: true,
                              //onPageChanged: callbackFunction,
                              scrollDirection: Axis.horizontal,
                            )),
                        Container(
                          padding: const EdgeInsets.only(top: 20),
                          child: AppBar(
                            foregroundColor: Colors.black,
                            actions: [
                              PopupMenuButton<String>(
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
                              )
                            ],
                            backgroundColor: Colors.transparent,
                            elevation: 0.0,
                          ),
                        ),
                      ],
                    ),
                    Center(
                      child: Container(
                        color: secColor,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 20),
                        child: Column(
                          children: [
                            CustomText(
                              title: model.name.toString(),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1,
                            ),
                            Container(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              alignment: Alignment.centerLeft,
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  RatingBar.builder(
                                    initialRating: 4,
                                    minRating: 1,
                                    direction: Axis.horizontal,
                                    allowHalfRating: true,
                                    itemSize: 18,
                                    itemCount: 5,
                                    wrapAlignment: WrapAlignment.start,
                                    itemBuilder: (context, _) => const Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 5,
                                    ),
                                    onRatingUpdate: (rating) {
                                      print(rating);
                                    },
                                  ),
                                  const CustomText(
                                    title: "(4000 Reviews)",
                                    fontSize: 12,
                                  ),
                                ],
                              ),
                            ),
                            CustomText(
                                title: model.price.toString() + "EGP",
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                            const SizedBox(
                              height: 30,
                            ),
                            const CustomText(
                              title: "Details",
                              fontSize: 16,
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
                    )
                  ],
                ),
              ],
            ),
          )),
          Positioned(
            child: addToCartButton(),
            bottom: 20,
            right: 0,
            left: 0,
          ),
        ],
      ),
    );
  }

  Widget addToCartButton() {
    return GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (controller) {
          return GestureDetector(
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
            child: Container(
              height: 50,
              decoration: BoxDecoration(
                  color: primaryColor, borderRadius: BorderRadius.circular(10)),
              margin: const EdgeInsets.symmetric(horizontal: 20),
              child: const CustomText(
                title: 'Add To Cart',
                color: Colors.white,
                fontSize: 18,
                //fontWeight: FontWeight.bold,
                alignment: Alignment.center,
              ),
            ),
          );
        });
  }
}

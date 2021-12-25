import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/wishlist_view_model.dart';
import 'package:e_commerce/view/app/product_details/product_details_view.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/widgets/productsShowingStyles/fav_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class WishList extends StatelessWidget {
  const WishList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GetBuilder<WishlistViewModel>(
        init: Get.find<WishlistViewModel>(),
        builder: (controller) => controller.wishlistItems.isEmpty
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
                          title: "Wishlist Empty",
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
                          itemCount: controller.wishlistProducts.length,
                          itemBuilder: (context, index) {
                            return FavoriteProductWidget(
                                onDismissed: () {
                                  controller.deleteProductFromWishlist(
                                      controller
                                          .wishlistProducts[index].productId!
                                          .toString());
                                },
                                onTap: () {
                                  Get.to(() => DetailsView(
                                        model:
                                            controller.wishlistProducts[index],
                                      ));
                                },
                                onChanged: () {},
                                imageUrl: controller
                                    .wishlistProducts[index].image
                                    .toString(),
                                title: controller.wishlistProducts[index].name
                                    .toString(),
                                price: controller.wishlistProducts[index].price
                                    .toString(),
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

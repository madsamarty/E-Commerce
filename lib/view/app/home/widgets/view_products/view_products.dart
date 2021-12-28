import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/view/app/product_details/product_details_view.dart';
import 'package:e_commerce/view/widgets/customs/custom_text.dart';
import 'package:e_commerce/view/widgets/square_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

class ViewProducts extends StatelessWidget {
  String title;
  List<ProductModel> pmList;
  ViewProducts({
    Key? key,
    required this.title,
    required this.pmList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      //height: 270,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  title: title,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
                const CustomText(
                  title: 'See all',
                  fontSize: 12,
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<HomeViewModel>(
            init: Get.find<HomeViewModel>(),
            builder: (controller) => SizedBox(
              //height: MediaQuery.of(context).size.height * 0.3,
              height: 210,
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: pmList.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return SquareProductWidget(
                      onTap: () {
                        /* Get.to(() =>
                      DetailsView(model: controller.productModelList[index])); */
                        pushNewScreen(context,
                            screen: DetailsView(model: pmList[index]),
                            withNavBar: true);
                      },
                      image: pmList[index].image!,
                      title: pmList[index].name.toString(),
                      dis: pmList[index].dis.toString(),
                      price: pmList[index].price!.toString() /* + "\$" */);
                },
                separatorBuilder: (BuildContext context, int index) =>
                    const SizedBox(
                  width: 20,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

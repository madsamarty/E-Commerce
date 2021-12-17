import 'package:e_commerce/constance.dart';
import 'package:e_commerce/view_model/home_view_model.dart';
import 'package:e_commerce/view/app/home/details_view.dart';
import 'package:e_commerce/view/widgets/category_product_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

class CategoryView extends StatelessWidget {
  const CategoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => Scaffold(
          appBar: AppBar(
            title: Text(controller.categoryTitle),
          ),
          body: Container(
            padding: const EdgeInsets.all(10),
            color: backgroundColor,
            child: GridView.builder(
              //padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.8,
                  mainAxisSpacing: 10),
              itemCount: controller.productByCategoryList.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Get.to(() => DetailsView(
                        model: controller.productByCategoryList[index]));
                  },
                  child: CategoryProduct(
                    image: controller.productByCategoryList[index].image!,
                    title: controller.productByCategoryList[index].name!,
                    dis: controller.productByCategoryList[index].dis!,
                    price: controller.productByCategoryList[index].price!,
                  ),
                );
              },
            ),
          )),
    );
  }
}

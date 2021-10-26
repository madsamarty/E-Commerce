import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/view/details_view.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class HomeView extends StatelessWidget {
  HomeView({Key? key}) : super(key: key);
  final List<String> names = <String>[
    'Men',
    'Women',
    'Devices',
    'Gadgets',
    'Gaming',
    'Sporting',
    'Hiking',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              body: Container(
              padding: const EdgeInsets.only(top: 50),
              color: Colors.white,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        _searchTextFormField(),
                        const SizedBox(
                          height: 25,
                        ),
                        const CustomText(
                          title: "Categories",
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                      ],
                    ),
                  ),
                  _listViewCategory(),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            CustomText(
                              title: 'Best Selling',
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              alignment: Alignment.center,
                            ),
                            CustomText(
                              title: 'See all',
                              alignment: Alignment.center,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        _listViewProducts()
                      ],
                    ),
                  ),
                ],
              ),
            )),
    );
  }

  Widget _searchTextFormField() {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40), color: Colors.grey.shade100),
      child: TextFormField(
          decoration: const InputDecoration(
        border: InputBorder.none,
        prefixIcon: Icon(
          Icons.search,
          color: Colors.black,
        ),
      )),
    );
  }

  Widget _listViewCategory() {
    return GetBuilder<HomeViewModel>(
        builder: (controller) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              height: 100,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.separated(
                  itemCount: controller.categroyModel.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.grey.shade100,
                                    spreadRadius: 0,
                                    blurRadius: 7,
                                    offset: const Offset(0, 3)),
                              ]),
                          height: 60,
                          width: 60,
                          child: Container(
                            padding: const EdgeInsets.all(13),
                            child: Image.network(
                                controller.categroyModel[index].image),
                          ),
                        ),
                        const SizedBox(height: 7),
                        CustomText(
                          fontSize: 13,
                          title: controller.categroyModel[index].name,
                        )
                      ],
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const SizedBox(
                    width: 20,
                  ),
                ),
              ),
            ));
  }

  Widget _listViewProducts() {
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => SizedBox(
        height: 350,
        child: ListView.separated(
          itemCount: controller.productModel.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                Get.to(
                    () => DetailsView(model: controller.productModel[index]));
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width * .4,
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50),
                          color: Colors.grey.shade100,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.1),
                                offset: const Offset(4, 4),
                                blurRadius: 7)
                          ]),
                      child: SizedBox(
                          height: 240,
                          width: MediaQuery.of(context).size.width * .4,
                          child: Image.network(
                            controller.productModel[index].image!,
                            fit: BoxFit.fill,
                          )),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    CustomText(
                      fontSize: 18,
                      title: controller.productModel[index].name.toString(),
                      alignment: Alignment.bottomLeft,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      fontSize: 14,
                      color: Colors.grey,
                      title: controller.productModel[index].dis.toString(),
                      alignment: Alignment.bottomLeft,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      fontSize: 18,
                      title: controller.productModel[index].price.toString() +
                          " \$",
                      color: primaryColor,
                      alignment: Alignment.bottomLeft,
                    ),
                  ],
                ),
              ),
            );
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 20,
          ),
        ),
      ),
    );
  }
}

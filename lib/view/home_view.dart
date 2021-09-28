import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
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
              //padding: EdgeInsets.symmetric(horizontal: 10),
              height: 100,
              child: ListView.separated(
                //itemCount: names.length,
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
                        height: 65,
                        width: 65,
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
            ));
  }

  Widget _listViewProducts() {
    return Container(
      height: 350,
      child: ListView.separated(
        itemCount: names.length,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
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
                  child: Container(
                      height: 240,
                      width: MediaQuery.of(context).size.width * .4,
                      child: Image.asset(
                        'assets/images/Image.png',
                        fit: BoxFit.fill,
                      )),
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomText(
                  fontSize: 18,
                  title: names[index],
                  alignment: Alignment.bottomLeft,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  fontSize: 14,
                  color: Colors.grey,
                  title: names[index],
                  alignment: Alignment.bottomLeft,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomText(
                  fontSize: 18,
                  title: names[index],
                  color: primaryColor,
                  alignment: Alignment.bottomLeft,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const SizedBox(
          width: 20,
        ),
      ),
    );
  }
}

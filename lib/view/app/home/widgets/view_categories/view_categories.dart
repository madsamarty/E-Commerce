import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/data/model/category_model.dart';
import 'package:e_commerce/widgets/customs/custom_text.dart';

class ViewCategories extends StatelessWidget {
  String title;
  List<CategoryModel> catModelList;
  ViewCategories({
    Key? key,
    required this.title,
    required this.catModelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Row(
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
              ],
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          GetBuilder<HomeViewModel>(
              builder: (controller) => SizedBox(
                    height: 40,
                    child:
                        NotificationListener<OverscrollIndicatorNotification>(
                      onNotification:
                          (OverscrollIndicatorNotification overscroll) {
                        overscroll.disallowGlow();
                        return true;
                      },
                      child: ListView.separated(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          itemCount: catModelList.length,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.only(right: 10),
                                //height: double.infinity,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: Colors.grey.shade300,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.shade100,
                                          spreadRadius: 0,
                                          blurRadius: 7,
                                          offset: const Offset(0, 3)),
                                    ]),
                                child: Row(
                                  //mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    SizedBox(
                                      width: 40,
                                      height: 40,
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        child: Image.network(
                                          catModelList[index].image,
                                          fit: BoxFit.scaleDown,
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 7),
                                    CustomText(
                                      fontSize: 13,
                                      title: catModelList[index].name,
                                      alignment: Alignment.center,
                                    )
                                  ],
                                ),
                              ),
                              onTap: () {
                                controller.getSpecificCategory(context, index);
                              },
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) =>
                              const SizedBox(
                                width: 15,
                              )),
                    ),
                  ))
        ],
      ),
    );
  }
}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/data/model/ad_model.dart';
import 'package:e_commerce/widgets/ad_widget.dart';

class ViewAds extends StatelessWidget {
  final CarouselController buttonCarouselController;
  List<AdModel> adModelList;

  ViewAds({
    Key? key,
    required this.buttonCarouselController,
    required this.adModelList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return (Get.find<HomeViewModel>().adModel.isEmpty)
        ? Container()
        : GetBuilder<HomeViewModel>(
            init: Get.find<HomeViewModel>(),
            builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CarouselSlider.builder(
                  carouselController: buttonCarouselController,
                  itemCount: adModelList.length,
                  itemBuilder:
                      (BuildContext context, int itemIndex, int pageViewIndex) {
                    return AdWidget(url: adModelList[itemIndex].image);
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
  }
}

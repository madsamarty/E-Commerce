import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/view/app/home/widgets/view_ads/view_ads.dart';
import 'package:e_commerce/view/app/home/widgets/view_categories/view_categories.dart';
import 'package:e_commerce/view/app/home/widgets/view_products/view_products.dart';
import 'package:e_commerce/widgets/ad_widget.dart';
import 'package:e_commerce/widgets/customs/custom_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
//import 'package:pull_to_refresh/pull_to_refresh.dart';

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
  final String name = "ESHTRY";

  final CarouselController _buttonCarouselController = CarouselController();

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeViewModel>(
        init: Get.find<HomeViewModel>(),
        builder: (controller) => controller.loading.value
            ? const Center(child: CircularProgressIndicator())
            : Scaffold(
                backgroundColor: backgroundColor,
                resizeToAvoidBottomInset: false,
                body: GestureDetector(
                  onTap: () {
                    FocusScope.of(context).requestFocus(FocusNode());
                  },
                  child: SafeArea(
                    right: true,
                    minimum: EdgeInsets.zero,
                    child: NestedScrollView(
                        headerSliverBuilder: (context, index) => [
                              SliverAppBar(
                                floating: true,
                                pinned: true,
                                snap: true,
                                centerTitle: true,
                                elevation: 0.0,
                                backgroundColor: backgroundColor,
                                title: CustomText(
                                  title: name,
                                  color: primaryColor,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  letterSpacing: 2,
                                ),
                                // SEARCH BAR
                                bottom: AppBar(
                                  toolbarHeight: 50,
                                  title: _searchTextFormField(),
                                  backgroundColor: backgroundColor,
                                  elevation: 0.0,
                                ),
                              ),
                            ],
                        body: Builder(builder: (context) {
                          return SmartRefresher(
                            controller: controller.refreshController,
                            onRefresh: controller.onRefresh,
                            onLoading: controller.onLoading,
                            child: SingleChildScrollView(
                              child: Column(
                                children: [
                                  //ADS
                                  ViewAds(
                                      buttonCarouselController:
                                          _buttonCarouselController,
                                      adModelList: controller.adModel),
                                  //CATEGORIES
                                  ViewCategories(
                                    title: "Categories",
                                    catModelList: controller.categroyModel,
                                  ),
                                  //BEST SELLING
                                  ViewProducts(
                                      title: "Hot Deals",
                                      pmList: controller.productModelList),
                                  //BEST SELLING
                                  ViewProducts(
                                      title: "Best Selling",
                                      pmList: controller.productModelList),
                                ],
                              ),
                            ),
                          );
                        })),
                  ),
                ),
              ));
  }

  Widget _searchTextFormField() {
    return Container(
      height: 40,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Center(
        child: TextFormField(
            textAlign: TextAlign.start,
            textAlignVertical: TextAlignVertical.top,
            decoration: const InputDecoration(
              hintText: "Search",
              alignLabelWithHint: false,
              border: InputBorder.none,
              prefixIcon: Icon(
                Icons.search,
                color: Colors.black,
              ),
            )),
      ),
    );
  }
}

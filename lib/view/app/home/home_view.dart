import 'package:carousel_slider/carousel_slider.dart';
import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:e_commerce/view/app/product_details/product_details_view.dart';
import 'package:e_commerce/view/widgets/ad_widget.dart';
import 'package:e_commerce/view/widgets/productsShowingStyles/main_product_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
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
                              child: Container(
                                //margin: const EdgeInsets.only(top: 80),
                                /* padding:
                                    const EdgeInsets.symmetric(horizontal: 8), */
                                child: Column(
                                  children: [
                                    //ADS
                                    Container(
                                        margin:
                                            const EdgeInsets.only(bottom: 10),
                                        child: _listViewAds()),
                                    //CATEGORIES
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        children: [
                                          _categoriesSeeAll(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          _listViewCategory(),
                                        ],
                                      ),
                                    ),
                                    //BEST SELLING
                                    Container(
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Column(
                                        //mainAxisSize: MainAxisSize.min,
                                        children: [
                                          _bestSellingSeeAll(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          _listViewProducts(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          _bestSellingSeeAll(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          _listViewProducts(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          _bestSellingSeeAll(),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          _listViewProducts()
                                        ],
                                      ),
                                    )
                                  ],
                                ),
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
      //padding: const EdgeInsets.symmetric(vertical: 10),
      //width: double.infinity,
      //height: double.infinity,
      //padding: EdgeInsets.only(bottom: 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10), color: Colors.white),
      child: Center(
        //padding: EdgeInsets.only(bottom: 5),
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

  Widget _listViewAds() {
    return (Get.find<HomeViewModel>().adModel.isEmpty)
        ? Container()
        : GetBuilder<HomeViewModel>(
            init: Get.find<HomeViewModel>(),
            builder: (controller) => Container(
              margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              child: CarouselSlider.builder(
                  carouselController: _buttonCarouselController,
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
  }

  Widget _categoriesSeeAll() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              CustomText(
                title: "Categories",
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
              CustomText(
                title: 'See all',
                fontSize: 12,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listViewCategory() {
    return GetBuilder<HomeViewModel>(
        builder: (controller) => SizedBox(
              height: 40,
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (OverscrollIndicatorNotification overscroll) {
                  overscroll.disallowGlow();
                  return true;
                },
                child: ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: controller.categroyModel.length,
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
                                    controller.categroyModel[index].image,
                                    fit: BoxFit.scaleDown,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 7),
                              CustomText(
                                fontSize: 13,
                                title: controller.categroyModel[index].name,
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
            ));
  }

  Widget _bestSellingSeeAll() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: const [
          CustomText(
            title: 'Best Selling',
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
          CustomText(
            title: 'See all',
            fontSize: 12,
          ),
        ],
      ),
    );
  }

  Widget _listViewProducts() {
    return GetBuilder<HomeViewModel>(
      init: Get.find<HomeViewModel>(),
      builder: (controller) => SizedBox(
        height: 190,
        child: ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemCount: controller.productModelList.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return ProductWidget(
                onTap: () {
                  /* Get.to(() =>
                      DetailsView(model: controller.productModelList[index])); */
                  pushNewScreen(context,
                      screen: DetailsView(
                          model: controller.productModelList[index]),
                      withNavBar: true);
                },
                image: controller.productModelList[index].image!,
                title: controller.productModelList[index].name.toString(),
                //dis: controller.productModelList[index].dis.toString(),
                price:
                    controller.productModelList[index].price.toString() + "\$");
          },
          separatorBuilder: (BuildContext context, int index) => const SizedBox(
            width: 20,
          ),
        ),
      ),
    );
  }
}

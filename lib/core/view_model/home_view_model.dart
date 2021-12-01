import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/services/home_services.dart';
import 'package:e_commerce/model/ad_model.dart';
import 'package:e_commerce/model/category_model.dart';
import 'package:e_commerce/model/product_by_category_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:e_commerce/view/home/categorie_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<AdModel> get adModel => _adModel;
  final List<AdModel> _adModel = [];
  List<CategoryModel> get categroyModel => _categroyModel;
  final List<CategoryModel> _categroyModel = [];
  List<ProductModel> get productModel => _productModel;
  final List<ProductModel> _productModel = [];
  List<ProductModel> get productByCategoryList => _productByCategoryList;
  final List<ProductModel> _productByCategoryList = [];

  String get categoryTitle => _categoryTitle;
  late String _categoryTitle;

  RefreshController get refreshController => _refreshController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //late var CurrentCategory = "".obs;

  HomeViewModel() {
    getAds();
    getCategories();
    getBestSellingProducts();
  }

  getAds() async {
    _loading.value = true;
    await HomeServices().getAds().then((value) {
      for (int i = 0; i < value.length; i++) {
        _adModel.add(AdModel.fromJson(value[i].data() as Map<String, dynamic>));
        _loading.value = false;
      }
      update();
    });
  }

  getCategories() async {
    _loading.value = true;
    await HomeServices().getAllCategory().then((value) {
      for (int i = 0; i < value.length; i++) {
        _categroyModel.add(
            CategoryModel.fromJson(value[i].data() as Map<String, dynamic>));
        //print(_categroyModel.length);
        _loading.value = false;
      }
      update();
    });
  }

  getBestSellingProducts() async {
    _loading.value = true;
    await HomeServices().getBestSelling().then((value) {
      for (int i = 0; i < value.length; i++) {
        _productModel.add(
            ProductModel.fromJson(value[i].data() as Map<String, dynamic>));
        //print(_categroyModel.length);
        _loading.value = false;
      }
      update();
    });
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    adModel.clear();
    getAds();

    _refreshController.refreshCompleted();
  }

  void onLoading() {}

  getSpecificCategory(int index) async {
    _categoryTitle = _categroyModel[index].name.toString();
    print(_categoryTitle);
    _productByCategoryList.clear();
    await HomeServices().getSpecCat(_categoryTitle).then((value) {
      //assert(value != null);
      for (int i = 0; i < value.length; i++) {
        _productByCategoryList.add(
            ProductModel.fromJson(value[i].data() as Map<String, dynamic>));
      }
      Get.to(() => const CategoryView());
      update();

      //print(_productByCategoryList.length);
    });
  }
}

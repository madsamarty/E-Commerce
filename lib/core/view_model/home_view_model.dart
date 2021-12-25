import 'dart:convert';

import 'package:e_commerce/core/services/home_services.dart';
import 'package:e_commerce/data/model/user_model.dart';
import 'package:e_commerce/helper/local_storage_data.dart';
import 'package:e_commerce/core/view_model/auth_view_model.dart';
import 'package:e_commerce/data/model/ad_model.dart';
import 'package:e_commerce/data/model/category_model.dart';
import 'package:e_commerce/data/model/product_model.dart';
import 'package:e_commerce/view/app/home/categorie_view.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/state_manager.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  LocalStorageData localStorageData = Get.find();

  UserModel get userModel => _userModel;
  late UserModel _userModel = UserModel();
  List<AdModel> get adModel => _adModel;
  final List<AdModel> _adModel = [];
  List<CategoryModel> get categroyModel => _categroyModel;
  final List<CategoryModel> _categroyModel = [];
  List<ProductModel> get productModelList => _productModelList;
  final List<ProductModel> _productModelList = [];
  List<ProductModel> get productByCategoryList => _productByCategoryList;
  final List<ProductModel> _productByCategoryList = [];

  String get categoryTitle => _categoryTitle;
  late String _categoryTitle;

  RefreshController get refreshController => _refreshController;
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);

  //late var CurrentCategory = "".obs;

  HomeViewModel() {
    //getCurrentUser();
    getAds();
    getCategories();
    getBestSellingProducts();
  }

  /*void getCurrentUser() async {
    _loading.value = true;
    await localStorageData.getUser.then((value) {
      _userModel = value!;
    });
    _loading.value = false;
    update();
  }*/

  getAds() async {
    _loading.value = true;
    await HomeServices().getAds().then((value) {
      for (int x = 0; x < value.length; x++) {
        _adModel.add(AdModel.fromJson(value[x].data() as Map<String, dynamic>));
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
        _productModelList.add(
            ProductModel.fromJson(value[i].data() as Map<String, dynamic>?));
        //print(_categroyModel.length);
        _loading.value = false;
      }
      update();
    });
  }

  void onRefresh() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    adModel.clear();
    productModelList.clear();
    try {
      getAds();
      getBestSellingProducts();
    } catch (e) {
      update();
    }
    update();
    _refreshController.refreshCompleted();
  }

  void onLoading() {}

  getSpecificCategory(BuildContext context, int index) async {
    _categoryTitle = _categroyModel[index].name.toString();
    print(_categoryTitle);
    _productByCategoryList.clear();
    await HomeServices().getSpecCat(_categoryTitle).then((value) {
      //assert(value != null);
      for (int i = 0; i < value.length; i++) {
        _productByCategoryList.add(
            ProductModel.fromJson(value[i].data() as Map<String, dynamic>));
      }
      //Get.to(() => const CategoryView());
      pushNewScreen(context, screen: const CategoryView(), withNavBar: true);
      update();

      //print(_productByCategoryList.length);
    });
  }
}

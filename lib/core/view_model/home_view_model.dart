import 'package:e_commerce/core/services/home_services.dart';
import 'package:e_commerce/model/category_model.dart';
import 'package:e_commerce/model/product_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CategoryModel> get categroyModel => _categroyModel;
  final List<CategoryModel> _categroyModel = [];
  List<ProductModel> get productModel => _productModel;
  final List<ProductModel> _productModel = [];

  HomeViewModel() {
    getCategory();
    getBestSellingProducts();
  }

  getCategory() async {
    _loading.value = true;
    await HomeServices().getCategory().then((value) {
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
            ProductModel.fromJson(value[i].data() as Map<dynamic, dynamic>));
        //print(_categroyModel.length);
        _loading.value = false;
      }
      update();
    });
  }
}

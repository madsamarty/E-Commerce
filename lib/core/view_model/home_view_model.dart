import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_commerce/core/services/home_services.dart';
import 'package:e_commerce/model/category_model.dart';
import 'package:flutter/widgets.dart';
import 'package:get/state_manager.dart';

class HomeViewModel extends GetxController {
  ValueNotifier<bool> get loading => _loading;
  final ValueNotifier<bool> _loading = ValueNotifier(false);

  List<CategoryModel> get categroyModel => _categroyModel;
  final List<CategoryModel> _categroyModel = [];

  HomeViewModel() {
    getCategory();
  }

  getCategory() async {
    _loading.value = true;
    await HomeServices().getCategory().then((value) {
      for (int i = 0; i < value.length; i++) {
        _categroyModel.add(
            CategoryModel.fromJson(value[i].data() as Map<String, dynamic>));
        print(_categroyModel.length);
        _loading.value = false;
      }
      update();
    });
  }
}

import 'package:e_commerce/constance.dart';
import 'package:e_commerce/view/app/cart/cart_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class CheckOutViewModel extends GetxController {
  int get index => _index;
  int _index = 0;

  Pages get pages => _pages;
  Pages _pages = Pages.DeliveryTime;

  void changeIndex(int i) {
    _index = i;
    if (index == 0) {
      _pages = Pages.DeliveryTime;
    } else if (_index == 1) {
      _pages = Pages.AddAddress;
    } else if (_index == 2) {
      _pages = Pages.Summary;
    } else if (_index == 3) {
      Get.to(() => CartView());
      _index = 0;
    }
    update();
  }

  Color getColor(int index) {
    if (index == _index) {
      return Colors.black;
    } else if (index < _index) {
      return Colors.black;
    } else {
      return todoColor;
    }
  }
}

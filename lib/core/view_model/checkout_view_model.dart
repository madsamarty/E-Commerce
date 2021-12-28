import 'package:e_commerce/constants/constance.dart';
import 'package:e_commerce/view/app/cart/cart_view.dart';
import 'package:e_commerce/view/app/control_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/state_manager.dart';

class CheckOutViewModel extends GetxController {
  int get index => _index;
  int _index = 0;

  Pages get pages => _pages;
  Pages _pages = Pages.DeliveryTime;

  Delivery get delivery => _delivery;
  Delivery _delivery = Delivery.standardDelivery;

  void changeIndex(int i) {
    _index = i;
    if (index == 0) {
      _pages = Pages.DeliveryTime;
    } else if (_index == 1) {
      _pages = Pages.AddAddress;
    } else if (_index == 2) {
      _pages = Pages.Summary;
    } else if (_index == 3) {
      Get.back();
      _index = 0;
    }
    update();
  }

  void changeTimeValue(Delivery changedValue) {
    _delivery = changedValue;
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

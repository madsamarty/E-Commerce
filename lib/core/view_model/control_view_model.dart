import 'package:e_commerce/view/app/cart/cart_view.dart';
import 'package:e_commerce/view/app/home/home_view.dart';
import 'package:e_commerce/view/app/profile/profile_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControlViewModel extends GetxController {
  //const ControlViewModel({ Key? key }) : super(key: key);

  int _navigatorValue = 0;

  get navigatorValue => _navigatorValue;
  Widget _currentScreen = HomeView();
  get currentScreen => _currentScreen;
  void changeSelectedValue(int selectedValue) {
    _navigatorValue = selectedValue;
    switch (selectedValue) {
      case 0:
        _currentScreen = HomeView();
        break;
      case 1:
        _currentScreen = CartView();
        break;
      case 2:
        _currentScreen = ProfileView();
        break;
    }
    update();
  }
}

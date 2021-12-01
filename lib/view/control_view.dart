import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/auth_view_model.dart';
import 'package:e_commerce/core/view_model/control_view_model.dart';
import 'package:e_commerce/view/cart/cart_view.dart';
import 'package:e_commerce/view/profile/profile_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:flutter/Cupertino.dart';
import 'package:persistent_bottom_nav_bar/persistent-tab-view.dart';

import 'auth/login_view.dart';
import 'home/home_view.dart';

class ControlView extends GetWidget<AuthViewModel> {
  const ControlView({Key? key}) : super(key: key);

  //Widget currentScreen = HomeScreen();
  //ControlView({Key? key}) : super(key: key);

  /* final PersistentTabController _controller =
      PersistentTabController(initialIndex: 0); */

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user == null)
          ? LoginView()
          : GetBuilder<ControlViewModel>(
              init: Get.find<ControlViewModel>(),
              builder: (controller) => Scaffold(
                body: controller.currentScreen,
                bottomNavigationBar: bottomNavBar(),
              ),
            );
    });
  }

  Widget bottomNavBar() {
    return GetBuilder<ControlViewModel>(
      init: Get.find<ControlViewModel>(),
      builder: (controller) => BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.home,
              color: primaryColor,
            ),
            icon: Icon(
              Icons.home,
              //size: 20,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.shopping_cart,
              color: primaryColor,
            ),
            icon: Icon(
              Icons.shopping_cart,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            activeIcon: Icon(
              Icons.person,
              color: primaryColor,
            ),
            icon: Icon(Icons.person),
            label: 'Account',
          ),
        ],
        currentIndex: controller.navigatorValue,
        onTap: (index) {
          controller.changeSelectedValue(index);
        },
        //elevation: 0,
        selectedItemColor: Colors.grey,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
      ),
    );
  }
}

import 'package:e_commerce/core/view_model/auth_view_model.dart';
import 'package:e_commerce/core/view_model/control_view_model.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

import 'auth/login_view.dart';
import 'home_view.dart';

class ControlView extends GetWidget<AuthViewModel> {
  //Widget currentScreen = HomeScreen();
  //ControlView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      return (Get.find<AuthViewModel>().user == null)
          ? LoginView()
          : GetBuilder<ControlViewModel>(
              builder: (controller) => Scaffold(
                body: controller.currentScreen,
                bottomNavigationBar: bottomNavBar(),
              ),
            );
    });
  }

  Widget bottomNavBar() {
    return Container(
      //margin: const EdgeInsets.only(top: 30),
      child: GetBuilder<ControlViewModel>(
        init: ControlViewModel(),
        builder: (controller) => BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/Icon_Explore_Green.png',
                  fit: BoxFit.contain,
                  width: 20,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/Icon_Explore_white.png',
                  fit: BoxFit.contain,
                  width: 20,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/Icon_Cart_Green.png',
                  fit: BoxFit.contain,
                  width: 20,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/Icon_Cart_White.png',
                  fit: BoxFit.contain,
                  width: 20,
                ),
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              activeIcon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/Icon_User_Green.png',
                  fit: BoxFit.contain,
                  width: 20,
                ),
              ),
              icon: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  'assets/images/Icon_User_white.png',
                  fit: BoxFit.contain,
                  width: 20,
                ),
              ),
              label: '',
            ),
          ],
          currentIndex: controller.navigatorValue,
          onTap: (index) {
            controller.changeSelectedValue(index);
          },
          elevation: 0,
          selectedItemColor: Colors.white,
          backgroundColor: Colors.black,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }
}

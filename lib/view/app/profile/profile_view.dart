import 'package:e_commerce/constants/constance.dart';
import 'package:e_commerce/core/view_model/home_view_model.dart';
import 'package:e_commerce/core/view_model/profile_view_model.dart';
import 'package:e_commerce/view/app/profile/sign_out/sign_out_alert_dialog.dart';
import 'package:e_commerce/view/widgets/customs/custom_list_tile.dart';
import 'package:e_commerce/view/widgets/customs/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ProfileViewModel>(
      init: Get.find<ProfileViewModel>(),
      builder: (controller) => controller.loading.value
          ? const Center(child: CircularProgressIndicator())
          : Scaffold(
              backgroundColor: backgroundColor,
              body: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Row(
                            children: [
                              Container(
                                //padding: const EdgeInsets.fromLTRB(5, 30, 25, 10),
                                margin: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 50),
                                child: Container(
                                  width: 80,
                                  height: 80,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      image: DecorationImage(
                                          image: NetworkImage(
                                              controller.userModel.pic))),
                                ),
                              ),
                              Expanded(
                                child: Column(
                                  children: [
                                    CustomText(
                                      title: controller.userModel.name,
                                      fontSize: 28,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    CustomText(
                                      title: controller.userModel.email,
                                      fontSize: 14,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ],
                                ),
                              ),
                              const SignOutAlertDialog()
                            ],
                          ),
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/editing.png",
                          title: "Edit Profile",
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/location.png",
                          title: "Shipping Address",
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/history.png",
                          title: "Order History",
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/credit-card.png",
                          title: "Cards",
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/notification.png",
                          title: "Notifications",
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }
}

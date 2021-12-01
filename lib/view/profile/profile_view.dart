import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/profile_view_model.dart';
import 'package:e_commerce/view/global_widgets/custom_list_tile.dart';
import 'package:e_commerce/view/global_widgets/custom_text.dart';
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
              //backgroundColor: Colors.white,
              body: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 15),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
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
                                  children: const [
                                    CustomText(
                                      title: /* controller.userModel.name */ "Mohamed",
                                      fontSize: 28,
                                      alignment: Alignment.centerLeft,
                                    ),
                                    CustomText(
                                      title: /* controller.userModel.name */ "Mohamed",
                                      fontSize: 14,
                                      alignment: Alignment.centerLeft,
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        ),
                        /* const SizedBox(
                    height: 50,
                  ), */
                        const CustomListTile(
                          leadingIcon: "assets/icons/Icon_Edit-Profile.png",
                          title: "Edit Profile",
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/Icon_Edit-Profile.png",
                          title: "Shipping Address",
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/Icon_Edit-Profile.png",
                          title: "Order History",
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/Icon_Edit-Profile.png",
                          title: "Cards",
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/Icon_Edit-Profile.png",
                          title: "Notifications",
                        ),
                        const CustomListTile(
                          leadingIcon: "assets/icons/Icon_Edit-Profile.png",
                          title: "Log Out",
                        ),
                      ],
                    ),
                  )),
            ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';

import 'package:e_commerce/constants/constance.dart';
import 'package:e_commerce/view/widgets/customs/custom_text.dart';
import 'package:e_commerce/core/view_model/cart_view_model.dart';

class CartProductWidget extends StatelessWidget {
  final Function onDismissed;
  final Function onTap;
  final Function onChanged;
  final String imageUrl;
  final String title;
  final String price;
  final int quantity;
  final int index;

  const CartProductWidget({
    Key? key,
    required this.onDismissed,
    required this.onTap,
    required this.onChanged,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.quantity,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      behavior: HitTestBehavior.translucent,
      direction: DismissDirection.endToStart,
      movementDuration: const Duration(milliseconds: 500),
      background: Container(
        color: Colors.red,
        child: const Icon(
          Icons.delete,
          color: Colors.white,
        ),
      ),
      key: UniqueKey(),
      onDismissed: (direction) {
        onDismissed();
      },
      confirmDismiss: (direction) async {
        return await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text("Confirm"),
              content: const Text("Are you sure you wish to delete this item?"),
              actions: <Widget>[
                TextButton(
                    onPressed: () => Navigator.of(context).pop(true),
                    child: const Text("DELETE")),
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text("CANCEL"),
                ),
              ],
            );
          },
        );
      },
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              SizedBox(
                  height: 130,
                  width: 130,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.scaleDown,
                    ),
                  )),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: title,
                        fontSize: 18,
                      ),
                      CustomText(
                        title: price + " EGP",
                        color: primaryColor,
                        fontSize: 18,
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.grey.shade200,
                          ),
                          height: 30,
                          width: 120,
                          padding: const EdgeInsets.symmetric(horizontal: 10),

                          //width: double.maxFinite / 3,
                          child: quantityMenu(index))
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget quantityMenu(int i) {
    return GetBuilder<CartViewModel>(
        init: Get.find<CartViewModel>(),
        builder: (controller) {
          return DropdownButton<String>(
            value: quantity.toString(),
            iconSize: 24,
            items: <String>['1', '2', '3', '4']
                .map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? newValue) {
              onChanged();
              /* dropdownValue = value;
              controller.changeQuantity(value, i); */
            },
          );
        });
  }
}

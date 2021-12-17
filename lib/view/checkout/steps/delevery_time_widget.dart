import 'package:e_commerce/constance.dart';
import 'package:e_commerce/view_model/checkout_view_model.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DeliveryTime extends StatelessWidget {
  DeliveryTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutViewModel>(
        init: Get.find<CheckOutViewModel>(),
        builder: (controller) => Expanded(
              child: Container(
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    RadioListTile<Delivery>(
                      value: Delivery.standardDelivery,
                      selected: true,
                      groupValue: controller.delivery,
                      onChanged: (value) {
                        controller.changeTimeValue(value!);
                      },
                      title: const CustomText(
                        title: "Standard Delivery",
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: const CustomText(
                        title:
                            "Order will be delivered between 3 - 5 business days",
                        fontSize: 15,
                        color: Colors.black,
                        maxLine: 2,
                      ),
                      activeColor: primaryColor,
                      isThreeLine: true,
                    ),
                    RadioListTile<Delivery>(
                      value: Delivery.nextDayDelivery,
                      //selected: true,
                      groupValue: controller.delivery,
                      onChanged: (value) {
                        controller.changeTimeValue(value!);
                      },
                      title: const CustomText(
                        title: "Next Day Delivery",
                        //fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: const CustomText(
                        title:
                            "Place your order before 6pm and your items will be delivered the next day",
                        fontSize: 15,
                        //color: Colors.grey,
                        maxLine: 2,
                        // letterSpacing: 1,
                      ),
                      activeColor: primaryColor,
                      isThreeLine: true,
                    ),
                    RadioListTile<Delivery>(
                      value: Delivery.nominatedDelivery,
                      //selected: true,
                      groupValue: controller.delivery,
                      onChanged: (value) {
                        controller.changeTimeValue(value!);
                      },
                      title: const CustomText(
                        title: "Nominated Delivery",
                        //fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      subtitle: const CustomText(
                        title:
                            "Pick a particular date from the calendar and order will be delivered on selected date",
                        fontSize: 15,
                        //color: Colors.grey,
                        maxLine: 2,
                      ),
                      activeColor: primaryColor,
                      isThreeLine: true,
                    ),
                  ],
                ),
              ),
            ));
  }
}

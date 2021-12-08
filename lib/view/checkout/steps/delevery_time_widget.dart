import 'package:e_commerce/constance.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class DeliveryTime extends StatelessWidget {
  const DeliveryTime({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.only(top: 50),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RadioListTile<Delivery>(
              value: Delivery.standardDelivery,
              selected: true,
              groupValue: null,
              onChanged: (value) {},
              title: const CustomText(
                title: "Standard Delivery",
                //fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
              subtitle: const CustomText(
                title: "Order will be delivered between 3 - 5 business days",
                fontSize: 14,
                color: Colors.grey,
              ),
              activeColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}

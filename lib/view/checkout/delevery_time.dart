import 'package:flutter/material.dart';

class DeliveryTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          RadioListTile(value: false, groupValue: () {}, onChanged: (value) {}),
        ],
      ),
    );
  }
}

import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/checkout_view_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CheckOutView extends StatelessWidget {
  CheckOutView({Key? key}) : super(key: key);
  //final Controller c =   Get.put(()=> CheckOutViewModel());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutViewModel>(
        autoRemove: false,
        init: CheckOutViewModel(),
        builder: (controller) => Scaffold(
              appBar: AppBar(
                centerTitle: true,
                backgroundColor: Colors.white,
                elevation: 0.0,
                title: const Text(
                  "CheckOut",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
              backgroundColor: Colors.white,
              floatingActionButton: FloatingActionButton(
                child: const Icon(Icons.skip_next),
                onPressed: () {
                  //print(_processIndex);
                  controller.changeIndex(controller.index + 1);
                },
                backgroundColor: inProgressColor,
              ),
            ));
  }
}

final List _processes = [
  'Delivery',
  'Address',
  'Summer',
];

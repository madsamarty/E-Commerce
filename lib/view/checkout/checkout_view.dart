import 'package:e_commerce/constance.dart';
import 'package:e_commerce/core/view_model/checkout_view_model.dart';
import 'package:e_commerce/view/checkout/add_address.dart';
import 'package:e_commerce/view/checkout/delevery_time.dart';
import 'package:e_commerce/view/checkout/summary.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:status_change/status_change.dart';

class CheckOutView extends StatelessWidget {
  const CheckOutView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutViewModel>(
        init: Get.find<CheckOutViewModel>(),
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
              body: Column(
                children: [
                  SizedBox(
                    height: 100,
                    child: StatusChange.tileBuilder(
                      theme: StatusChangeThemeData(
                        direction: Axis.horizontal,
                        connectorTheme: const ConnectorThemeData(
                            space: 1.0, thickness: 1.0),
                      ),
                      builder: StatusChangeTileBuilder.connected(
                        itemWidth: (_) => Get.width / _processes.length,
                        nameWidgetBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 15.0),
                            child: Text(
                              _processes[index],
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: controller.getColor(index),
                              ),
                            ),
                          );
                        },
                        indicatorWidgetBuilder: (_, index) {
                          if (index <= controller.index) {
                            return DotIndicator(
                              size: 35.0,
                              border: Border.all(color: Colors.green, width: 1),
                              child: Padding(
                                padding: const EdgeInsets.all(6.0),
                                child: Container(
                                  decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Colors.green,
                                  ),
                                ),
                              ),
                            );
                          } else {
                            return OutlinedDotIndicator(
                              size: 30,
                              borderWidth: 1.0,
                              color: todoColor,
                            );
                          }
                        },
                        lineWidgetBuilder: (index) {
                          if (index > 0) {
                            if (index == controller.index) {
                              final prevColor = controller.getColor(index - 1);
                              final color = controller.getColor(index);
                              var gradientColors;
                              gradientColors = [
                                prevColor,
                                Color.lerp(prevColor, color, 0.5)
                              ];
                              return DecoratedLineConnector(
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    colors: gradientColors,
                                  ),
                                ),
                              );
                            } else {
                              return SolidLineConnector(
                                color: controller.getColor(index),
                              );
                            }
                          } else {
                            return null;
                          }
                        },
                        itemCount: _processes.length,
                      ),
                    ),
                  ),
                  controller.pages == Pages.DeliveryTime
                      ? DeliveryTime()
                      : controller.pages == Pages.AddAddress
                          ? AddAddress()
                          : Summary()
                ],
              ),
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

final _processes = [
  'Delivery',
  'Address',
  'Summer',
];

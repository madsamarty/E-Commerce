import 'dart:math';

import 'package:e_commerce/constants/constance.dart';
import 'package:e_commerce/core/view_model/checkout_view_model.dart';
import 'package:e_commerce/view/app/cart/cart_view.dart';
import 'package:e_commerce/view/app/control_view.dart';
import 'package:e_commerce/view/app/home/home_view.dart';
import 'package:e_commerce/view/app/cart/checkout/steps/add_address_widget.dart';
import 'package:e_commerce/view/app/cart/checkout/steps/delevery_time_widget.dart';
import 'package:e_commerce/view/app/cart/checkout/steps/delevery_time_widget.dart';
import 'package:e_commerce/view/app/cart/checkout/steps/delevery_time_widget.dart';
import 'package:e_commerce/view/app/cart/checkout/steps/summary_widget.dart';
import 'package:e_commerce/view/widgets/customs/custom_flat_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:timelines/timelines.dart';

import 'steps/delevery_time_widget.dart';
//import 'package:status_change/status_change.dart';

class MainCheckOutView extends StatelessWidget {
  MainCheckOutView({Key? key}) : super(key: key);

  final _processes = [
    'Delivery',
    'Address',
    'Summary',
  ];

  @override
  Widget build(BuildContext context) {
    return GetBuilder<CheckOutViewModel>(
        init: CheckOutViewModel(),
        builder: (controller) {
          return Scaffold(
            resizeToAvoidBottomInset: false,
            appBar: AppBar(
              centerTitle: true,
              backgroundColor: Colors.white,
              elevation: 0.0,
              leading: IconButton(
                  onPressed: () {
                    if (controller.index == 0) {
                      Get.back();
                    } else {
                      controller.changeIndex(controller.index - 1);
                    }
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                  )),
              title: const Text(
                "Order Status",
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
            backgroundColor: Colors.white,
            body: GestureDetector(
              onTap: () {
                FocusScope.of(context).requestFocus(FocusNode());
              },
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 100,
                    //padding: const EdgeInsets.all(20),
                    child: Timeline.tileBuilder(
                      theme: TimelineThemeData(
                          direction: Axis.horizontal,
                          connectorTheme: const ConnectorThemeData(
                              space: 1.0, thickness: 1.0)),
                      builder: TimelineTileBuilder.connected(
                        connectionDirection: ConnectionDirection.before,
                        itemExtentBuilder: (_, __) =>
                            MediaQuery.of(context).size.width /
                            _processes.length,
                        contentsBuilder: (context, index) {
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
                        indicatorBuilder: (_, index) {
                          var color;
                          var child;
                          if (index == controller.index) {
                            color = primaryColor;
                            child = const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                strokeWidth: 3.0,
                                valueColor:
                                    AlwaysStoppedAnimation(Colors.white),
                              ),
                            );
                          } else if (index < controller.index) {
                            color = primaryColor;
                            child = const Icon(
                              Icons.circle,
                              color: Colors.white,
                              size: 15.0,
                            );
                          } else {
                            color = todoColor;
                          }
                          if (index <= controller.index) {
                            return Stack(
                              children: [
                                CustomPaint(
                                  size: const Size(30.0, 30.0),
                                  painter: _BezierPainter(
                                    color: color,
                                    drawStart: index > 0,
                                    drawEnd: index < controller.index,
                                  ),
                                ),
                                DotIndicator(
                                  size: 30.0,
                                  color: color,
                                  child: child,
                                ),
                              ],
                            );
                          } else {
                            return Stack(
                              children: [
                                CustomPaint(
                                  size: const Size(15.0, 15.0),
                                  painter: _BezierPainter(
                                    color: color,
                                    drawEnd: index < _processes.length - 1,
                                  ),
                                ),
                                OutlinedDotIndicator(
                                  borderWidth: 4.0,
                                  color: color,
                                ),
                              ],
                            );
                          }
                        },
                        connectorBuilder: (_, index, type) {
                          if (index > 0) {
                            if (index == controller.index) {
                              final prevColor = controller.getColor(index - 1);
                              final color = controller.getColor(index);
                              List<Color> gradientColors;
                              if (type == ConnectorType.start) {
                                gradientColors = [primaryColor, color];
                              } else {
                                gradientColors = [
                                  prevColor,
                                  Color.lerp(prevColor, color, 1)!
                                ];
                              }
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
                          : Summary(),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 60),
                    child: CustomTextButton(
                      title: "Next",
                      onPress: () {
                        controller.changeIndex(controller.index + 1);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}

class _BezierPainter extends CustomPainter {
  const _BezierPainter({
    required this.color,
    this.drawStart = true,
    this.drawEnd = true,
  });

  final Color color;
  final bool drawStart;
  final bool drawEnd;

  Offset _offset(double radius, double angle) {
    return Offset(
      radius * cos(angle) + radius,
      radius * sin(angle) + radius,
    );
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..style = PaintingStyle.fill
      ..color = color;

    final radius = size.width / 2;

    var angle;
    var offset1;
    var offset2;

    var path;

    /* if (drawStart) {
      angle = 3 * pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);
      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(0.0, size.height / 2, -radius,
            radius) // TODO connector start & gradient
        ..quadraticBezierTo(0.0, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    } */
    /* if (drawEnd) {
      angle = -pi / 4;
      offset1 = _offset(radius, angle);
      offset2 = _offset(radius, -angle);

      path = Path()
        ..moveTo(offset1.dx, offset1.dy)
        ..quadraticBezierTo(size.width, size.height / 2, size.width + radius,
            radius) // TODO connector end & gradient
        ..quadraticBezierTo(size.width, size.height / 2, offset2.dx, offset2.dy)
        ..close();

      canvas.drawPath(path, paint);
    } */
  }

  @override
  bool shouldRepaint(_BezierPainter oldDelegate) {
    return oldDelegate.color != color ||
        oldDelegate.drawStart != drawStart ||
        oldDelegate.drawEnd != drawEnd;
  }
}

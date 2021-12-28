import 'package:e_commerce/constance.dart';
import 'package:e_commerce/widgets/customs/custom_text.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SquareProductWidget extends StatelessWidget {
  final String image, title, dis;
  final String price;
  final Function onTap;

  const SquareProductWidget({
    Key? key,
    required this.image,
    required this.title,
    required this.dis,
    required this.price,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        //margin: const EdgeInsets.all(3),
        padding: const EdgeInsets.all(10),
        width: MediaQuery.of(context).size.width * .4,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5), color: Colors.white),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          //direction: Axis.vertical,
          children: [
            AspectRatio(
              aspectRatio: 4 / 3,
              child: Image.network(
                image,
                fit: BoxFit.contain,
                scale: 1,
                //width: MediaQuery.of(context).size.width * 0.5,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomText(
              fontSize: 18,
              title: title,
              alignment: Alignment.bottomLeft,
            ),
            const SizedBox(
              height: 5,
            ),
            CustomText(
              fontSize: 14,
              color: Colors.grey,
              title: dis,
              maxLine: 1,
              alignment: Alignment.bottomLeft,
            ),
            const SizedBox(
              height: 5,
            ),
            CustomText(
              fontSize: 18,
              title: price.toString(),
              color: primaryColor,
              alignment: Alignment.bottomLeft,
            ),
          ],
        ),
      ),
    );
  }
}

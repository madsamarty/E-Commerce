import 'package:e_commerce/constance.dart';
import 'package:e_commerce/view/global_widgets/custom_text.dart';
import 'package:flutter/material.dart';

class CategoryProduct extends StatelessWidget {
  final String image, title, dis, price;
  //final Function onTap;

  const CategoryProduct({
    Key? key,
    required this.image,
    required this.title,
    required this.dis,
    required this.price,
    //required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      //mainAxisSize: MainAxisSize.max,
      //direction: Axis.vertical,
      children: [
        Expanded(
          flex: 1,
          child: Image.network(
            image,
            fit: BoxFit.fill,
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
          title: price,
          color: primaryColor,
          alignment: Alignment.bottomLeft,
        ),
      ],
    );
  }
}

import 'package:e_commerce/constants/constance.dart';
import 'package:e_commerce/view/widgets/customs/custom_text.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final String image, title, price;
  final Function onTap;

  const ProductWidget({
    Key? key,
    required this.image,
    required this.title,
    //required this.dis,
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
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: Colors.white,
        ),
        width: MediaQuery.of(context).size.width * .4,
        child: Expanded(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(
                  //height: 240,
                  //width: MediaQuery.of(context).size.width * .4,
                  child: AspectRatio(
                aspectRatio: 4 / 3,
                child: Image.network(
                  image,
                  fit: BoxFit.scaleDown,
                ),
              )),
              const SizedBox(
                height: 20,
              ),
              CustomText(
                fontSize: 16,
                title: title,
                alignment: Alignment.bottomLeft,
              ),
              const SizedBox(
                height: 5,
              ),
              /* CustomText(
                fontSize: 14,
                color: Colors.grey,
                title: dis,
                alignment: Alignment.bottomLeft,
              ),
              const SizedBox(
                height: 5,
              ), */
              CustomText(
                fontSize: 16,
                title: price,
                alignment: Alignment.bottomLeft,
                fontWeight: FontWeight.bold,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

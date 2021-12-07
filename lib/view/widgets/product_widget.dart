import 'package:e_commerce/constance.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class ProductWidget extends StatelessWidget {
  final String image, title, dis, price;
  final Function onTap;

  const ProductWidget({
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
      child: SizedBox(
        width: MediaQuery.of(context).size.width * .4,
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.grey.shade100,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey.withOpacity(0.1),
                        offset: const Offset(10, 10),
                        blurRadius: 7)
                  ]),
              child: SizedBox(
                  //height: 240,
                  width: MediaQuery.of(context).size.width * .4,
                  child: Image.network(
                    image,
                    fit: BoxFit.cover,
                  )),
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
        ),
      ),
    );
  }
}

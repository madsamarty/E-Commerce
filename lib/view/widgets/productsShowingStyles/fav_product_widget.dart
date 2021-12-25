import 'package:e_commerce/constance.dart';
import 'package:e_commerce/view/widgets/custom_text.dart';
import 'package:flutter/material.dart';

class FavoriteProductWidget extends StatelessWidget {
  final Function onDismissed;
  final Function onTap;
  final Function onChanged;
  final String imageUrl;
  final String title;
  final String price;
  final int index;
  const FavoriteProductWidget({
    Key? key,
    required this.onDismissed,
    required this.onTap,
    required this.onChanged,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.index,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: UniqueKey(),
      onDismissed: (direction) {
        onDismissed();
      },
      child: GestureDetector(
        onTap: () {
          onTap();
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          height: 150,
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Row(
            children: [
              SizedBox(
                  height: 130,
                  width: 130,
                  child: AspectRatio(
                    aspectRatio: 4 / 3,
                    child: Image.network(
                      imageUrl,
                      fit: BoxFit.scaleDown,
                    ),
                  )),
              Expanded(
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CustomText(
                        title: title,
                        fontSize: 18,
                      ),
                      CustomText(
                        title: price + "\$",
                        color: primaryColor,
                        fontSize: 18,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

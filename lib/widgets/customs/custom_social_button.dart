import 'package:e_commerce/widgets/customs/custom_text.dart';
import 'package:flutter/material.dart';

class CustomSocialButton extends StatelessWidget {
  final String title;
  final String icon;
  final Function onPress;

  const CustomSocialButton(
      {Key? key, this.title = "Unnamed", this.icon = "", required this.onPress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
          border: Border.all(width: 0.8, color: Colors.grey),
          borderRadius: BorderRadius.circular(5)),
      child: TextButton(
          onPressed: () {
            onPress();
          },
          style: TextButton.styleFrom(
            enableFeedback: false,
          ),
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Image.asset(icon, scale: 1.2),
                Expanded(
                    child: CustomText(
                  title: title,
                  fontSize: 12,
                  alignment: Alignment.center,
                )),
                const SizedBox(
                  width: 40,
                  height: 40,
                )
              ],
            ),
          )),
    );
  }
}

import 'package:flutter/material.dart';

import '../../constance.dart';
import 'custom_text.dart';

class CustomTextButton extends StatelessWidget {

  final String title;
  final Color backgroundColor;
  final Color textColor;
  final Function onPress;

  const CustomTextButton({Key? key, this.title = "Untitled", this.backgroundColor = btnBgColor, required this.onPress, this.textColor = btnTxtColor}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPress(),
      style: TextButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5)
        ),
        padding: const EdgeInsets.all(18),
        backgroundColor: backgroundColor,
        textStyle: const TextStyle(
          fontWeight: FontWeight.bold
        )
      ),
      child: CustomText(
        title: title,
        color: textColor,
        alignment: Alignment.center,
      ),
    );
  }
}

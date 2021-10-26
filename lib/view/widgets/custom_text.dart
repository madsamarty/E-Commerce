import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;
  final Alignment alignment;
  final TextDecoration deco;
  final FontWeight fontWeight;
  final int maxLine;
  final double height;
  final double letterSpacing;

  const CustomText(
      {Key? key,
      this.title = "",
      this.fontSize = 16,
      this.color = Colors.black,
      this.alignment = Alignment.topLeft,
      this.deco = TextDecoration.none,
      this.fontWeight = FontWeight.normal,
      this.maxLine = 1,
      this.letterSpacing = 0,
      this.height = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(title,
          maxLines: maxLine,
          style: TextStyle(
            height: height,
            color: color,
            fontSize: fontSize,
            decoration: deco,
            fontWeight: fontWeight,
            letterSpacing: letterSpacing,
          )),
    );
  }
}

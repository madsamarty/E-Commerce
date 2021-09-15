import 'package:flutter/material.dart';

class CustomText extends StatelessWidget {
  final String title;
  final double fontSize;
  final Color color;
  final Alignment alignment;
  final TextDecoration deco;
  final FontWeight fontWeight;

  const CustomText(
      {Key? key,
      this.title = "",
      this.fontSize = 16,
      this.color = Colors.black,
      this.alignment = Alignment.topLeft,
      this.deco = TextDecoration.none,
      this.fontWeight = FontWeight.normal})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: alignment,
      child: Text(title,
          style: TextStyle(
              color: color,
              fontSize: fontSize,
              decoration: deco,
              fontWeight: fontWeight)),
    );
  }
}

import 'package:e_commerce/constants/constance.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'custom_text.dart';

class CustomTextFromField extends StatelessWidget {
  // Custom Text
  final String title;
  final double fontSize;
  final Color color;
  final Alignment alignment;
  final TextDecoration deco;
  final FontWeight fontWeight;
  final int maxLine;
  final double height;
  final double letterSpacing;

  // Custom TextFormField
  final String hint;
  final void Function(String?)? onSave;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final TextInputType txtInType;
  final bool obscure;

  const CustomTextFromField(
      {Key? key,
      this.hint = "",
      required this.onSave,
      required this.validator,
      required this.controller,
      this.txtInType = TextInputType.none,
      this.obscure = false,
      this.title = "",
      this.fontSize = 16,
      this.color = Colors.black,
      this.alignment = Alignment.centerLeft,
      this.deco = TextDecoration.none,
      this.fontWeight = FontWeight.normal,
      this.maxLine = 1,
      this.letterSpacing = 0,
      this.height = 1})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      //padding: const EdgeInsets.symmetric(vertical: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title,
              maxLines: maxLine,
              style: TextStyle(
                height: height,
                color: color,
                fontSize: fontSize,
                decoration: deco,
                fontWeight: fontWeight,
                letterSpacing: letterSpacing,
              )),
          TextFormField(
            cursorColor: primaryColor,
            decoration:
                InputDecoration(hintText: hint, hoverColor: primaryColor),
            keyboardType: TextInputType.visiblePassword,
            obscureText: obscure,
            controller: controller,
            onSaved: onSave,
            validator: validator,
          ),
        ],
      ),
    );
  }
}

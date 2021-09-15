import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomTextFromField extends StatelessWidget {
  final String title;
  final String hint;
  final Function onSave;
  final Function validator;

  const CustomTextFromField(
      {Key? key,
      this.title = "",
      required this.hint,
      required this.onSave,
      required this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
        child: Column(
      children: [
        CustomText(
          title: title,
          fontSize: 12,
          color: Colors.black,
        ),
        TextFormField(
          validator: validator(),
          onSaved: onSave(),
          decoration: InputDecoration(
              hintText: hint,
              hintStyle: const TextStyle(color: Colors.grey),
              fillColor: Colors.white),
        )
      ],
    ));
  }
}
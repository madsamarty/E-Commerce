import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

import 'custom_text.dart';

class CustomTextFromField extends StatelessWidget {
  final String name;
  final String title;
  final String hint;
  final Function onSave;
  final Function validator;

  const CustomTextFromField(
      {Key? key,
      this.title = "",
      required this.hint,
      required this.onSave,
      required this.validator,
      required this.name})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomText(
          title: title,
          fontSize: 12,
          color: Colors.black,
        ),
        FormBuilderTextField(name: name,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.grey),

        ),)
      ],
    );
  }
}



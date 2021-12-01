import 'package:flutter/material.dart';

import 'custom_text.dart';

class CustomSocialTap extends StatelessWidget {

  final String title;
  final String icon;
  final Function onpress;

  const CustomSocialTap({Key? key, required this.onpress, this.title = "Untitled", this.icon=""}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextButton(onPressed: onpress(), child: Text(title));
  }
}

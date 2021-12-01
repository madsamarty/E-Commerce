import 'package:flutter/material.dart';

class AdWidget extends StatelessWidget {
  final String url;

  const AdWidget({Key? key, required this.url}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      width: double.infinity,
      /* child: Image.network(
        url,
        fit: BoxFit.fill,
      ), */
      decoration: BoxDecoration(
        image: DecorationImage(image: NetworkImage(url), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}

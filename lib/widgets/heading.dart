import 'package:flutter/material.dart';

class Heading extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;
  const Heading({super.key, required this.text, required this.fontSize, required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topLeft,
      child: Padding(
          padding: const EdgeInsets.only(left: 9),
        child: Text(text, style: TextStyle(fontSize: fontSize, fontWeight: fontWeight, height: 0),),
      ),
    );
  }
}

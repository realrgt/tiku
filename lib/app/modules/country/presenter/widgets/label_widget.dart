import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  final double fontSize;
  final FontWeight fontWeight;

  Label(
    this.text, {
    Key? key,
    this.fontSize = 18.0,
    this.fontWeight = FontWeight.normal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(3.0),
      child: Text(
        text,
        style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight,
        ),
      ),
    );
  }
}

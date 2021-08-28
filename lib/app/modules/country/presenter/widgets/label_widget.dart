import 'package:flutter/material.dart';

class Label extends StatelessWidget {
  final String text;
  final TextStyle? style;

  Label(this.text, {Key? key, this.style}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(2.0),
      child: Text(text, style: style),
    );
  }
}

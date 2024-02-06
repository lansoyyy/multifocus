import 'package:flutter/material.dart';

class TextRegular extends StatelessWidget {
  late String text;
  late double fontSize;
  late Color color;
  TextAlign align;

  TextRegular({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.align = TextAlign.start,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: align,
      style:
          TextStyle(fontSize: fontSize, color: color, fontFamily: 'QRegular'),
    );
  }
}

class TextBold extends StatelessWidget {
  late String text;
  late double fontSize;
  late Color color;
  late TextOverflow? overFlow;

  TextBold({
    super.key,
    required this.text,
    required this.fontSize,
    required this.color,
    this.overFlow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      overflow: overFlow,
      style: TextStyle(
          fontSize: fontSize,
          color: color,
          fontFamily: 'QBold',
          fontWeight: FontWeight.w600),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:multifocus/widgets/text_widget.dart';

class ButtonWidget extends StatelessWidget {
  final String label;
  final VoidCallback onPressed;
  final double? width;
  final double? fontSize;
  final double? height;
  final Color? color;
  final double? radius;
  final Color? textColor;

  const ButtonWidget(
      {Key? key,
      required this.label,
      this.textColor = Colors.white,
      this.radius = 5,
      required this.onPressed,
      this.width = 300,
      this.fontSize = 18,
      this.height = 50,
      this.color = const Color(0xff6571E0)})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radius!)),
        minWidth: width,
        height: height,
        color: color,
        onPressed: onPressed,
        child: TextBold(text: label, fontSize: fontSize!, color: textColor!));
  }
}

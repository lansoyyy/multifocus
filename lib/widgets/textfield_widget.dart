import 'package:flutter/material.dart';
import 'package:multifocus/widgets/text_widget.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final String? hint;
  final bool? isObscure;
  final TextEditingController controller;
  final double? width;
  final double? height;
  final int? maxLine;
  final TextInputType? inputType;
  final double? radius;
  final bool? filled;

  const TextFieldWidget(
      {super.key,
      this.filled = false,
      required this.label,
      this.hint = '',
      required this.controller,
      this.radius = 5,
      this.isObscure = false,
      this.width = 300,
      this.height = 35,
      this.maxLine = 1,
      this.inputType = TextInputType.text});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: TextRegular(text: label, fontSize: 12, color: Colors.black),
        ),
        const SizedBox(
          height: 7.5,
        ),
        Container(
          height: height,
          width: width,
          decoration:
              BoxDecoration(borderRadius: BorderRadius.circular(radius!)),
          child: TextFormField(
            style: const TextStyle(
                color: Colors.black, fontFamily: 'QRegular', fontSize: 12),
            keyboardType: inputType,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius!)),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(radius!)),
              filled: filled,
              fillColor: Colors.grey[200],
              hintText: hint,
              border: InputBorder.none,
            ),
            maxLines: maxLine,
            obscureText: isObscure!,
            controller: controller,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

class CommonTextWidget extends StatelessWidget {
  const CommonTextWidget({super.key, required this.text,this.textAlign, this.textSize, this.fontWeight, this.textColor});

  final String text;
  final TextAlign? textAlign;
  final double? textSize;
  final Color? textColor;
  final FontWeight? fontWeight;

  @override
  Widget build(BuildContext context) {
    return Text(text,textAlign: textAlign ?? TextAlign.left,style: TextStyle(
        fontWeight: fontWeight ?? FontWeight.normal,
        fontSize: textSize ?? 14,
        color: textColor ?? Colors.black
    ),);
  }
}
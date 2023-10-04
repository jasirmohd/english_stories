import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../resources/app_colors.dart';

class CommonTextFieldWidget extends StatelessWidget {
  const CommonTextFieldWidget(
      {Key? key, required this.controller,this.onChanged,this.action, this.format,this.onIconTap, this.passwordIcon, required this.fieldType, this.password, this.type, this.enabled, this.lines, this.maxLength, this.padding, required this.hint, this.fillColor, this.hintWeight, this.textSize, this.textWeight, this.textColor, this.align})
      : super(key: key);

  final TextEditingController controller;
  final String hint;
  final FontWeight? hintWeight;
  final TextAlign? align;
  final double? textSize;
  final FontWeight? textWeight;
  final Color? textColor;
  final Color? fillColor;
  final int? lines;
  final bool? enabled;
  final double? padding;
  final int? maxLength;
  final TextInputType? type;
  final bool? password;
  final String fieldType;
  final VoidCallback? onIconTap;
  final IconData? passwordIcon;
  final TextInputAction? action;
  final List<TextInputFormatter>? format;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: type ??TextInputType.text,
      maxLines: lines ?? 1,
      enabled: enabled ?? true,
      maxLength: maxLength,
      obscureText:  false,
      textInputAction: action ?? TextInputAction.next ,
      inputFormatters: format,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        counterText: '',
        suffix: IconButton(icon: const Icon(Icons.search_rounded),color:Colors.grey, iconSize: 15,onPressed: onIconTap,),
        fillColor: AppColors.white,
        border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(35.0),
            borderSide: const BorderSide(color: AppColors.black)
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 5.0),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey,
            fontSize: textSize ?? 14,
            fontWeight: hintWeight ?? FontWeight.normal),
      ),
      textAlign: align ?? TextAlign.start,
      style: TextStyle(
        fontWeight: textWeight,
        fontSize: textSize,
        color: textColor,
      ),
    );
  }

}
import 'package:diy/utils/theme_files/app_colors.dart';
import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final String? label;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final GestureTapCallback? onTap;
  const MyTextField(
      {Key? key,
      this.label,
      required this.hint,
      this.readOnly = false,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.prefixIcon,
      this.suffixIcon,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.textFieldBackground(context),
          borderRadius: BorderRadius.circular(4),
        ),
        child: TextField(
          onTap: onTap,
          controller: controller,
          readOnly: readOnly,
          keyboardType: keyboardType,
          cursorColor: AppColors.primaryColor(context),
          decoration: InputDecoration(
            fillColor: AppColors.textFieldBackground(context),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.textFieldBackground(context),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: AppColors.primaryColor(context),
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            hintText: hint,
            labelText: label,
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,
            border: OutlineInputBorder(
              borderSide: BorderSide(color: AppColors.primaryColor(context)),
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
      ),
    );
  }
}

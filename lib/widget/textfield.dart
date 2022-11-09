import 'package:flutter/material.dart';

class MyTextField extends StatelessWidget {
  final String hint;
  final String? label;
  final bool readOnly;
  final TextEditingController controller;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  const MyTextField(
      {Key? key,
      this.label,
      required this.hint,
      this.readOnly = false,
      required this.controller,
      this.keyboardType = TextInputType.text,
      this.prefixIcon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      readOnly: readOnly,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        hintText: hint,
        labelText: label,
        prefixIcon: prefixIcon,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}

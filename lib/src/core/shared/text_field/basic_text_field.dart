import 'package:flutter/material.dart';

class BasicTextField extends StatelessWidget {
  final TextEditingController? controller;
  final bool isObscureText;
  final String? hintText;
  final Widget? suffixIcon;
  const BasicTextField(
      {super.key,
      this.controller,
      this.isObscureText = false,
      this.hintText,
      this.suffixIcon});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      obscureText: isObscureText,
      decoration: InputDecoration(hintText: hintText, suffixIcon: suffixIcon),
    );
  }
}

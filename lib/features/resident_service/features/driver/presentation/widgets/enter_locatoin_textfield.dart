import 'package:flutter/material.dart';

class EnterLocationTextField extends StatelessWidget {
  const EnterLocationTextField({
    super.key,
    this.onChanged,
    this.controller,
    this.hintText,
    this.cursorColor,
    this.suffixIcon,
  });

  final ValueChanged<String>? onChanged;
  final TextEditingController? controller;
  final String? hintText;
  final Color? cursorColor;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      cursorColor: cursorColor,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.grey.shade300,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide.none,
        ),
        hintText: hintText,
        suffixIcon:
            suffixIcon ?? Icon(Icons.menu_book_rounded, color: Colors.green),
      ),
    );
  }
}

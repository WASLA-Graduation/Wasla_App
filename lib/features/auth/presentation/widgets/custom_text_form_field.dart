import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String? hint;
  final bool? isSecure;
  final IconButton? suffixIcon;
  final Widget? prefixIcon;
  final TextInputType? keyboardTyp;
  final void Function()? onTap;
  final TextEditingController? controller;
  final bool? readOnly;
  final int? maxLines;
  final String? initealValue;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.validator,
    required this.hint,
    this.isSecure,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardTyp,
    this.onTap,
    this.controller,
    this.readOnly,
    this.maxLines,
    this.initealValue,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initealValue,
      maxLines: maxLines ?? 1,
      readOnly: readOnly ?? false,
      controller: controller,
      keyboardType: keyboardTyp,
      cursorColor: AppColors.primaryColor,
      onTap: onTap,
      onChanged: onChanged,
      validator: validator,
      obscureText: isSecure ?? false,
      decoration: InputDecoration(
        errorStyle: Theme.of(context).textTheme.labelSmall!.copyWith(
          color: AppColors.error,
        ),
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: AppColors.gray.withOpacity(0.1),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 17,
        ),
        errorBorder: _customBorder(color: AppColors.error),
        focusedErrorBorder: _customBorder(color: AppColors.error),
        focusedBorder: _customBorder(color: AppColors.primaryColor),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(14),
        ),
        hintText: hint,
      ),
    );
  }

  OutlineInputBorder _customBorder({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 2),
      borderRadius: BorderRadius.circular(20),
    );
  }
}

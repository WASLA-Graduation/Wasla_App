import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final void Function(String)? onChanged;
  final String? Function(String?)? validator;
  final String hint;
  final bool? isSecure;
  final IconButton? suffixIcon;
  final Widget? prefixIcon;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.validator,
    required this.hint,
    this.isSecure,
    this.suffixIcon,
    this.prefixIcon,
  });

  @override
  Widget build(BuildContext context) {


    return TextFormField(
      cursorColor: AppColors.primaryColor,
      onChanged: onChanged,
      validator: validator,
      obscureText: isSecure ?? false,
      decoration: InputDecoration(
        prefixIcon: prefixIcon ?? const SizedBox(),
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
          borderRadius: BorderRadius.circular(20),
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

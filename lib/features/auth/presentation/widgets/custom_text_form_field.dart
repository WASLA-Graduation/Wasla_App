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
  final int? minLines;
  final String? initealValue;
  final String? labelText;
  final Color? fillColor;
  final bool? withTitle;
  final String? title;
  final bool? withBorder;

  const CustomTextFormField({
    super.key,
    this.onChanged,
    this.validator,
    this.hint,
    this.isSecure,
    this.suffixIcon,
    this.prefixIcon,
    this.keyboardTyp,
    this.onTap,
    this.controller,
    this.readOnly,
    this.maxLines,
    this.initealValue,
    this.labelText,
    this.fillColor,
    this.withTitle,
    this.title,
    this.withBorder,
    this.minLines,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        withTitle != null
            ? Text(title!, style: Theme.of(context).textTheme.headlineMedium)
            : SizedBox(height: 0),
        const SizedBox(height: 11),
        TextFormField(
          initialValue: initealValue,
          maxLines: maxLines ?? 1,
          minLines: minLines ?? 1,
          readOnly: readOnly ?? false,
          controller: controller,
          keyboardType: keyboardTyp,
          cursorColor: AppColors.primaryColor,
          onTap: onTap,
          onChanged: onChanged,
          validator: validator,
          obscureText: isSecure ?? false,
          decoration: InputDecoration(
            errorStyle: Theme.of(
              context,
            ).textTheme.headlineSmall!.copyWith(color: AppColors.error),
            prefixIcon: prefixIcon,
            suffixIcon: suffixIcon,

            filled: true,
            fillColor: fillColor ?? AppColors.gray.withOpacity(0.1),
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 10,
              vertical: 17,
            ),
            errorBorder: _customBorder(color: AppColors.red),
            focusedErrorBorder: _customBorder(color: AppColors.red),
            focusedBorder: _customBorder(color: AppColors.primaryColor),
            enabledBorder: OutlineInputBorder(
              borderSide: withBorder == true
                  ? const BorderSide(color: AppColors.gray, width: 0.3)
                  : BorderSide.none,
              borderRadius: BorderRadius.circular(14),
            ),
            hintText: hint,
            labelText: labelText,
            labelStyle: Theme.of(
              context,
            ).textTheme.headlineMedium!.copyWith(color: AppColors.primaryColor),
          ),
        ),
      ],
    );
  }

  OutlineInputBorder _customBorder({required Color color}) {
    return OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 2),
      borderRadius: BorderRadius.circular(20),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class ReviewInputField extends StatelessWidget {
  const ReviewInputField({
    super.key,
    required this.controller,
    required this.onChanged,
    required this.onSend,
    this.hintText,
    this.maxLines,
  });

  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final VoidCallback onSend;
  final String? hintText;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: maxLines,
      minLines: 1,
      controller: controller,
      onChanged: onChanged,
      decoration: InputDecoration(
        hintText: hintText,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        suffixIcon: IconButton(
          onPressed: controller.text.trim().isEmpty ? null : onSend,
          icon: Image.asset(
            controller.text.trim().isEmpty
                ? Assets.assetsImagesSendOutlined
                : Assets.assetsImagesSendFilled,
            width: 25,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

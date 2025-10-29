import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key, this.onTap, this.onChanged, this.readOnly});
  final VoidCallback? onTap;
  final ValueChanged<String>? onChanged;
  final bool? readOnly;

  @override
  Widget build(BuildContext context) {
    return TextField(
      readOnly: readOnly ?? true,
      onTap: onTap,
      onChanged: onChanged,
      decoration: InputDecoration(
        filled: true,
        fillColor: AppColors.gray.withOpacity(0.1),
        hintText: "Search for services",
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
        prefixIcon: IconButton(
          onPressed: () {},
          icon: Image.asset(
            Assets.assetsImagesSearch,
            width: 20,
            color: AppColors.gray,
          ),
        ),
        suffixIcon: IconButton(
          onPressed: () {},
          icon: Image.asset(
            Assets.assetsImagesFilter,
            width: 25,
            color: AppColors.primaryColor,
          ),
        ),
      ),
    );
  }
}

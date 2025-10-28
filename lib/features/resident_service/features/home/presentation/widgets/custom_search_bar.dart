import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomSearchBar extends StatelessWidget {
  const CustomSearchBar({super.key});

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: (value) {},
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

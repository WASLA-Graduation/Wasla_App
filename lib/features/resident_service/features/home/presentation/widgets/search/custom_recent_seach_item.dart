import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';

class CustomSearchRecentitem extends StatelessWidget {
  const CustomSearchRecentitem({super.key});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      title: Text(
        "Doctor",
        style: TextStyle(
          fontSize: 15,
          color: AppColors.gray,
          fontWeight: FontWeight.bold,
        ),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Image.asset(Assets.assetsImagesCloseIcon, color: AppColors.gray,width:25),
      ),
    );
  }
}

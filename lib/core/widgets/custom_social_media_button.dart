import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/size_config.dart';

class CustomSocialMediaButton extends StatelessWidget {
  const CustomSocialMediaButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.image,
  });
  final VoidCallback onPressed;
  final String text;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton.icon(
          onPressed: onPressed,
          label: Text(text),

          icon: Image.asset(image, width: 25),
          style: ElevatedButton.styleFrom(
            fixedSize: Size(double.maxFinite, 60),
            foregroundColor: context.isDarkMode ? Colors.white : Colors.black,
            textStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: SizeConfig.textSize * 2.2,
            ),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(20),
              side: BorderSide(color: AppColors.gray, width: .5),
            ),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}

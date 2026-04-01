import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_image_with_stack.dart';

class CustomDoctorDatailsCardWeiget extends StatelessWidget {
  const CustomDoctorDatailsCardWeiget({
    super.key,
    required this.child,
    required this.imageUrl,
    required this.withHero,
  });

  final Widget child;
  final String imageUrl;
  final bool withHero;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.1)
            : AppColors.whiteColor.withOpacity(0.2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            withHero
                ? Hero(
                    tag: imageUrl,
                    child: BuildImageWithStackWidget(imageUrl: imageUrl),
                  )
                : BuildImageWithStackWidget(imageUrl: imageUrl),
            const SizedBox(width: 18),
            Expanded(child: child),
          ],
        ),
      ),
    );
  }
}

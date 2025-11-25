import 'package:flutter/material.dart';
import 'package:readmore/readmore.dart';
import 'package:wasla/core/responsive/responsive_font_size.dart';
import 'package:wasla/core/utils/app_colors.dart';

class ReadmoreText extends StatelessWidget {
  final String text;
  final int? maxLines;
  const ReadmoreText({super.key, required this.text, this.maxLines});

  @override
  Widget build(BuildContext context) {
    return ReadMoreText(
      text,
      trimLines: maxLines ?? 2,
      trimMode: TrimMode.Line,
      trimCollapsedText: "View More",
      trimExpandedText: "Show Less",
      moreStyle: TextStyle(color: AppColors.primaryColor),
      lessStyle: TextStyle(color: AppColors.primaryColor),
      style: TextStyle(
        color: AppColors.gray,
        fontSize: getResponsiveFontSize(context, fontSize: 16),
      ),
    );
  }
}

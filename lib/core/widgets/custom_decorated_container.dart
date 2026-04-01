import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomDecoratedContainer extends StatelessWidget {
  const CustomDecoratedContainer({super.key, required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(13),
        border: Border.all(color: AppColors.primaryColor, width: 0.5),
      ),
      child: child,
    );
  }
}

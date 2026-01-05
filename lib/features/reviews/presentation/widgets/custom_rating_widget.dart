import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomRatingWidget extends StatelessWidget {
  const CustomRatingWidget({
    super.key,
    required this.rating,
    required this.isSelected,
  });
  final String rating;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 5, horizontal: 12),
      decoration: ShapeDecoration(
        color: isSelected ? AppColors.primaryColor : null,
        shape: StadiumBorder(
          side: BorderSide(width: 1, color: AppColors.primaryColor),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.star,
            color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
            size: 18,
          ),
          const SizedBox(width: 6),
          Text(
            rating,
            style: Theme.of(context).textTheme.displaySmall!.copyWith(
              color: isSelected ? AppColors.whiteColor : AppColors.primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

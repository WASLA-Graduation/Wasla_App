import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CategoryFilteritema extends StatelessWidget {
  // final DoctorSpecializationaModel doctorSpecializationaModel;
  final bool isSelected;
  const CategoryFilteritema({
    super.key,
    // required this.doctorSpecializationaModel,
    required this.isSelected,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10),
      padding: EdgeInsets.symmetric(horizontal: 20),
      decoration: ShapeDecoration(
        color: isSelected ? AppColors.primaryColor : null,
        shape: StadiumBorder(
          side: BorderSide(width: 2, color: AppColors.primaryColor),
        ),
      ),
      child: Center(
        child: Text(
          title,
          // doctorSpecializationaModel.specialization,
          style: isSelected
              ? Theme.of(
                  context,
                ).textTheme.headlineSmall!.copyWith(color: AppColors.whiteColor)
              : Theme.of(context).textTheme.headlineSmall!.copyWith(
                  color: AppColors.primaryColor,
                ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:skeletonizer/skeletonizer.dart';
import 'package:wasla/core/utils/app_colors.dart';

class SpecialityLoadingList extends StatelessWidget {
  const SpecialityLoadingList({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: Skeletonizer(
        enabled: true,
        child: ListView.builder(
          itemCount: 5,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) => Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            width: 100,
            height: 40,
            decoration: ShapeDecoration(
              color: AppColors.gray.withOpacity(0.1),
              shape: StadiumBorder(),
            ),
          ),
        ),
      ),
    );
  }
}

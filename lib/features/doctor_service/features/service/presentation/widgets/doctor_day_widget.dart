import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DoctorDaysList extends StatelessWidget {
  DoctorDaysList({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(3, (index) {
        return Container(
          margin: const EdgeInsets.only(right: 7),
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          decoration: ShapeDecoration(
            shape: StadiumBorder(),
            color: colors[index].withOpacity(0.1),
          ),
          child: Text(
            "Mon",
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(color: colors[index]),
          ),
        );
      }),
    );
  }

  final List<Color> colors = [
    AppColors.green,
    AppColors.blue,
    AppColors.orange,
    AppColors.red,
    AppColors.purple,
  ];
}

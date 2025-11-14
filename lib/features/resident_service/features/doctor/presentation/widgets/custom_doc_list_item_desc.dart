import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DoctorListItemDescriptionWidget extends StatelessWidget {
  const DoctorListItemDescriptionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          "Dr.Disha",
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        Text(
          "Dentist",
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(color: AppColors.gray),
        ),
        const SizedBox(height: 2),

        Row(
          children: [
            const Icon(Icons.star, color: Colors.amber, size: 18),
            const SizedBox(width: 6),
            Text("4.5", style: Theme.of(context).textTheme.displaySmall),
          ],
        ),
      ],
    );
  }
}

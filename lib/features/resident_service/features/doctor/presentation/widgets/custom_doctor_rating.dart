import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomDoctorInfoRating extends StatelessWidget {
  const CustomDoctorInfoRating({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.favorite_border, color: AppColors.primaryColor),
        ),

        Spacer(),
        Row(
          children: [
            Icon(Icons.star, color: Colors.amber),
            Flexible(
              child: FittedBox(
                child: Text(
                  '4.5',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

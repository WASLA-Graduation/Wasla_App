import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class UserNameAndEmailWidget extends StatelessWidget {
  const UserNameAndEmailWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              "Mostafa Salah",
              style: Theme.of(
                context,
              ).textTheme.displayMedium,
            ),
          ),
          const SizedBox(height: 12),
          FittedBox(
            fit: BoxFit.scaleDown,

            child: Text(
              "mostafasalahnabawy10@gmail.com",
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(color: AppColors.gray),
            ),
          ),
          const Divider(height: 50, thickness: 0.3),
        ],
      ),
    );
  }
}

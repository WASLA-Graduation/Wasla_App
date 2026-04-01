import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CustomResultSearchTextWidget extends StatelessWidget {
  const CustomResultSearchTextWidget({
    super.key,
    required this.total,
    required this.title,
  });
  final int total;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: Row(
        children: [
          Text.rich(
            style: Theme.of(context).textTheme.labelMedium,
            TextSpan(
              text: "Result for : ",

              children: [
                TextSpan(
                  text: '" $title"',
                  style: TextStyle(color: AppColors.primaryColor),
                ),
              ],
            ),
          ),
          Spacer(),
          Text(
            "$total founds",
            style: Theme.of(
              context,
            ).textTheme.titleSmall!.copyWith(color: AppColors.primaryColor),
          ),
        ],
      ),
    );
  }
}

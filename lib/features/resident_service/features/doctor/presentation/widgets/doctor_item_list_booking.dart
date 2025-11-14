import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DoctorItemListBooking extends StatelessWidget {
  const DoctorItemListBooking({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildFees(context),
        // SizedBox(height: 10),
        const Spacer(),
        _buildBookButton(context),
      ],
    );
  }

  FittedBox _buildFees(BuildContext context) {
    return FittedBox(
        fit: BoxFit.scaleDown,
        child: Row(
          children: [
            Text.rich(
              style: Theme.of(
                context,
              ).textTheme.displaySmall!.copyWith(color: AppColors.gray),
              TextSpan(
                children: [
                  TextSpan(text: "Fees    "),
                  TextSpan(
                    text: r'$50.99',
                    style: TextStyle(color: AppColors.primaryColor),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
  }

  MaterialButton _buildBookButton(BuildContext context) {
    return MaterialButton(
        onPressed: () {},
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 3),
        color: AppColors.primaryColor,
        height: 35,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "Book Now",
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(color: AppColors.whiteColor),
          ),
        ),
      );
  }
}

import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';

class ResidentAllBookingsList extends StatelessWidget {
  const ResidentAllBookingsList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      itemCount: 10,

      itemBuilder: (_, index) =>
          Container(color: AppColors.primaryColor, height: 30),
    );
  }
}

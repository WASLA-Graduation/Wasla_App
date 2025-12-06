import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/custom_doctor_chart.dart';

class DoctorDashboardBody extends StatelessWidget {
  const DoctorDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 20,
      children: [
        Row(
          children: [
            Expanded(child: CustomDocDashboardCard()),
            const SizedBox(width: 20),
            Expanded(child: CustomDocDashboardCard()),
          ],
        ),
        Row(
          children: [
            Expanded(child: CustomDocDashboardCard()),
            const SizedBox(width: 20),
            Expanded(child: CustomDocDashboardCard()),
          ],
        ),
        CustomDoctorChart(),
      ],
    );
  }
}

class CustomDocDashboardCard extends StatelessWidget {
  const CustomDocDashboardCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
        color: AppColors.whiteColor,
        borderRadius: BorderRadius.circular(13),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        spacing: 13,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: AppColors.green.withOpacity(0.3),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Icon(Icons.save, size: 17, color: AppColors.green),
              ),
              Text(
                'Revenue',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
              ),
            ],
          ),

          Text("245K", style: Theme.of(context).textTheme.displayMedium),
        ],
      ),
    );
  }
}

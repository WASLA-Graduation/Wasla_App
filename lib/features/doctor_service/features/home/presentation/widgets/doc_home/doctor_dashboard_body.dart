import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/custom_doc_dashboard_card.dart';
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
            Expanded(
              child: CustomDocDashboardCard(
                title: "patients".tr(context),
                value: 1.toString(),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomDocDashboardCard(
                title: "noOfBookings".tr(context),
                value: 2.toString(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomDocDashboardCard(
                title: "completedBookings".tr(context),
                value: 0.toString(),
              ),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: CustomDocDashboardCard(
                title: "totalRevenue".tr(context),
                value: 0.toString() + 'egb'.tr(context),
              ),
            ),
          ],
        ),
        CustomDoctorChart(),
      ],
    );
  }
}

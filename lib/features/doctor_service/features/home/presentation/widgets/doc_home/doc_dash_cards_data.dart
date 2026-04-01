import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/custom_doc_dashboard_card.dart';

class DoctorDashboardCardData extends StatelessWidget {
  const DoctorDashboardCardData({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorHomeCubit>();
    return Column(
      spacing: 20,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDocDashboardCard(
                title: "patients".tr(context),
                value:
                    cubit.doctorChartModel?.numOfPatients.toString() ??
                    0.toString(),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomDocDashboardCard(
                title: "noOfBookings".tr(context),
                value:
                    cubit.doctorChartModel?.numOfBookings.toString() ??
                    0.toString(),
              ),
            ),
          ],
        ),
        Row(
          children: [
            Expanded(
              child: CustomDocDashboardCard(
                title: "completedBookings".tr(context),
                value:
                    cubit.doctorChartModel?.numOfCompletedBookings.toString() ??
                    0.toString(),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomDocDashboardCard(
                title: "totalRevenue".tr(context),
                value:
                    "${cubit.doctorChartModel?.totalAmount ?? 0} ${'egb'.tr(context)}",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

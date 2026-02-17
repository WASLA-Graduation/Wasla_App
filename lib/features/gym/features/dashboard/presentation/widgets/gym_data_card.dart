import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/custom_doc_dashboard_card.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/manager/cubit/gym_dashboard_cubit.dart';

class GymDashboardDataCard extends StatelessWidget {
  const GymDashboardDataCard({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymDashboardCubit>();
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: CustomDocDashboardCard(
            title: "bookings".tr(context),
            value:
                cubit.gymStatisticsModel?.numberOfBookings.toString() ??
                0.toString(),
          ),
        ),
        Expanded(
          child: CustomDocDashboardCard(
            title: "trainnees".tr(context),
            value:
                cubit.gymStatisticsModel?.numberOfTrainees.toString() ??
                0.toString(),
          ),
        ),
        Expanded(
          child: CustomDocDashboardCard(
            title: "revenue".tr(context),
            value:
                cubit.gymStatisticsModel?.totalAmount.toString() ??
                0.toString(),
          ),
        ),
      ],
    );
  }
}

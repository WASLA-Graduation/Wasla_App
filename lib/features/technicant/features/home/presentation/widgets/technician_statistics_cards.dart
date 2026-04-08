import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/custom_doc_dashboard_card.dart';
import 'package:wasla/features/technicant/features/home/presentation/manager/cubit/technicant_dashboard_cubit.dart';

class TechnicianStatisticsCards extends StatelessWidget {
  const TechnicianStatisticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    bool isTablet = SizeConfig.isTablet;
    return isTablet ? _buildTabletLayout(context) : _buildMobileLayout(context);
  }

  Widget _buildTabletLayout(BuildContext context) {
    final cubit = context.read<TechnicantDashboardCubit>();
    return Row(
      children: [
        Expanded(
          child: CustomDocDashboardCard(
            title: "numberOfResidents".tr(context),
            value:
                cubit.technicianChart?.numberOfResidents.toString() ??
                0.toString(),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: CustomDocDashboardCard(
            title: "completedBookings".tr(context),
            value:
                cubit.technicianChart?.completedBookings.toString() ??
                0.toString(),
          ),
        ),
        const SizedBox(width: 15),
        Expanded(
          child: CustomDocDashboardCard(
            title: "totalRevenue".tr(context),
            value:
                "${cubit.technicianChart?.totalAmount.toStringAsFixed(0) ?? 0} ${'egb'.tr(context)}",
          ),
        ),
      ],
    );
  }

  Widget _buildMobileLayout(BuildContext context) {
    final cubit = context.read<TechnicantDashboardCubit>();
    return Column(
      spacing: 20,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDocDashboardCard(
                title: "numberOfResidents".tr(context),
                value:
                    cubit.technicianChart?.numberOfResidents.toString() ??
                    0.toString(),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomDocDashboardCard(
                title: "completedBookings".tr(context),
                value:
                    cubit.technicianChart?.completedBookings.toString() ??
                    0.toString(),
              ),
            ),
          ],
        ),

        Row(
          children: [
            Expanded(
              child: CustomDocDashboardCard(
                title: "totalRevenue".tr(context),
                value:
                    "${cubit.technicianChart?.totalAmount.toStringAsFixed(0) ?? 0} ${'egb'.tr(context)}",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

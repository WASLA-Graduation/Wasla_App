import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/custom_doc_dashboard_card.dart';
import 'package:wasla/features/driver/features/home/presentation/manager/cubit/driver_cubit.dart';

class DriverStatisticsCards extends StatelessWidget {
  const DriverStatisticsCards({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverCubit>();
    return Column(
      spacing: 20,
      children: [
        Row(
          children: [
            Expanded(
              child: CustomDocDashboardCard(
                title: "numberOfRides".tr(context),
                value:
                    cubit.driverChart?.numberOfRides.toString() ?? 0.toString(),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: CustomDocDashboardCard(
                title: "numberOfDeliveredResident".tr(context),
                value:
                    cubit.driverChart?.numberOfDeliveredResident.toString() ??
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
                    "${cubit.driverChart?.totalAmount.toStringAsFixed(0) ?? 0} ${'egb'.tr(context)}",
              ),
            ),
          ],
        ),
      ],
    );
  }
}

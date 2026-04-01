import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/dashbord%20and%20charts/custom_general_dashbord_drop_down.dart';
import 'package:wasla/features/driver/features/home/presentation/manager/cubit/driver_cubit.dart';
import 'package:wasla/features/driver/features/home/presentation/widgets/driver_statistics_cards.dart';

class DriverStatatistcsContent extends StatelessWidget {
  const DriverStatatistcsContent({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DriverCubit>();
    return Column(
      spacing: 25,
      children: [
        DriverStatisticsCards(),
        BlocBuilder<DriverCubit, DriverState>(
          buildWhen: (previous, current) =>
              current is DriverGetDashboardDataFromDropDown,
          builder: (context, state) {
            return DashboardChartCard(
              title: 'monthlyRevenue'.tr(context),
              years:
                  cubit.driverChart?.years.map((e) => e.year).toList() ??
                  [DateTime.now().year],
              selectedYear: cubit.initalSelectedYear,
              onYearChanged: (year) {
                cubit.getChartDataByYear(
                  year: int.parse(year!),
                  fromDropDown: true,
                );
              },
              yearDataModel: cubit.yearDataModel,
            );
          },
        ),
      ],
    );
  }
}

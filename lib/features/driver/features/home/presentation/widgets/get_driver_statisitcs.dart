import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/driver/features/home/presentation/manager/cubit/driver_cubit.dart';
import 'package:wasla/features/driver/features/home/presentation/widgets/driver_statatistcs_content.dart';

class GetDriverStatisitcs extends StatelessWidget {
  const GetDriverStatisitcs({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DriverCubit, DriverState>(
      buildWhen: (previous, current) =>
          current is DriverGetDashboardDataSuccess ||
          current is DriverGetDashboardDataLoading,
      builder: (context, state) {
        if (state is DriverGetDashboardDataLoading || state is DriverInitial) {
          return SliverFillRemaining(
            child: Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50,
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: DriverStatatistcsContent());
      },
    );
  }
}

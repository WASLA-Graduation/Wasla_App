import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/manager/cubit/gym_dashboard_cubit.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/widgets/gym_dashboard_content.dart';

class GymDashboardViewBody extends StatelessWidget {
  const GymDashboardViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymDashboardCubit, GymDashboardState>(
      builder: (context, state) {
        if (state is GymDashboardProfileGetProfileFailure ||
            state is GymDashboardProfileGetChartFailure ||
            state is GymDashboardProfileGetBookingsListFailure) {
          return const Center(child: CustomErrGetData());
        }

        if (state is GymDashboardProfileGetChartLoading ||
            state is GymDashboardProfileGetBookingsListLoading) {
          return const Center(
            child: SpinKitFadingCircle(color: AppColors.primaryColor, size: 50),
          );
        }

        return SingleChildScrollView(child: GymDashBoardContent());
      },
    );
  }
}

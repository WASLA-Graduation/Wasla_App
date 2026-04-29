import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/manager/cubit/gym_dashboard_cubit.dart';
import 'package:wasla/features/gym/features/dashboard/presentation/widgets/gym_dashboard_body.dart';

class GymDashboardView extends StatefulWidget {
  const GymDashboardView({super.key});

  @override
  State<GymDashboardView> createState() => _GymDashboardViewState();
}

class _GymDashboardViewState extends State<GymDashboardView> {
  @override
  void initState() {
    callApi();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocStatusHandler<GymDashboardCubit, GymDashboardState>(
        body: const GymDashboardViewBody(),
        onRetry: () {
          context.read<GymDashboardCubit>().onRetry();
          callApi();
        },
        isNetwork: (state) => state is GymDashboardNetwrorkState,
        isError: (state) => state is GymDashboardFailureState,
        buildWhen: (previous, current) =>
            current is GymDashboardNetwrorkState ||
            current is GymDashboardFailureState ||
            current is GymDashboardOnRetryState,
      ),
    );
  }

  void callApi() async {
    final cubit = context.read<GymDashboardCubit>();
    cubit.reset();
    cubit.getGymProfile();
    cubit.getGymStatistics();
    cubit.getGymBookingsByStatus();
  }
}

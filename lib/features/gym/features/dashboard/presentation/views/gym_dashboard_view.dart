import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
      child: GymDashboardViewBody(),
    );
  }

  void callApi() async {
    final cubit = context.read<GymDashboardCubit>();
    cubit.getGymProfile();
    cubit.getGymStatistics();
  }
}

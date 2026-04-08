import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/error_widget.dart';
import 'package:wasla/core/widgets/internet/no_internet_widget.dart';
import 'package:wasla/features/technicant/features/home/presentation/manager/cubit/technicant_dashboard_cubit.dart';
import 'package:wasla/features/technicant/features/home/presentation/widgets/technician_dahsboard_body.dart';

class TechnicianDashboardView extends StatefulWidget {
  const TechnicianDashboardView({super.key});

  @override
  State<TechnicianDashboardView> createState() =>
      _TechnicianDashboardViewState();
}

class _TechnicianDashboardViewState extends State<TechnicianDashboardView> {
  @override
  void initState() {
    getDataOfScreen();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: BlocBuilder<TechnicantDashboardCubit, TechnicantDashboardState>(
          buildWhen: (previous, current) =>
              current is TechnicianNetworkState ||
              current is TechnicianOnRetryState ||
              current is TechnicianErrorState,
          builder: (context, state) {
            if (state is TechnicianNetworkState) {
              return NoInternetWidget(
                onRetry: () {
                  context.read<TechnicantDashboardCubit>().whenRetry();
                  getDataOfScreen();
                },
              );
            } else if (state is TechnicianErrorState) {
              return MyErrorWidget(
                onRetry: () {
                  context.read<TechnicantDashboardCubit>().whenRetry();
                  getDataOfScreen();
                },
              );
            } else {
              return TechincianDashboardBody();
            }
          },
        ),
      ),
    );
  }

  void getDataOfScreen() {
    final cubit = context.read<TechnicantDashboardCubit>();
    cubit.getTechnicianProfile();
    cubit.getTechnicianStatistics();
  }
}

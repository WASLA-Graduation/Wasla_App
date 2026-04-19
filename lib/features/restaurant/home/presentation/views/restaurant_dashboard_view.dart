import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/restaurant/home/presentation/manager/cubit/restaurant_dashboard_cubit.dart';
import 'package:wasla/features/restaurant/home/presentation/widgets/restaurant_dashboard_body.dart';

class RestaurantDashboardView extends StatefulWidget {
  const RestaurantDashboardView({super.key});

  @override
  State<RestaurantDashboardView> createState() =>
      _RestaurantDashboardViewState();
}

class _RestaurantDashboardViewState extends State<RestaurantDashboardView> {
  @override
  void initState() {
    getDashboardData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child:
            BlocStatusHandler<
              RestaurantDashboardCubit,
              RestaurantDashboardState
            >(
              body: RestaurantDashboardBody(),
              onRetry: () {
                getDashboardData();
                context.read<RestaurantDashboardCubit>().onRetry();
              },
              isNetwork: (state) => state is RestaurantDashboardNetworkState,
              isError: (state) => state is RestaurantDashboardFailureState,
              buildWhen: (previous, current) =>
                  current is RestaurantDashboardNetworkState ||
                  current is RestaurantDashboardFailureState ||
                  current is RestaurantDashboardOnRetryState,
            ),
      ),
    );
  }

  void getDashboardData() {
    final cubit = context.read<RestaurantDashboardCubit>();
    cubit.getRestaurantData();
  }
}

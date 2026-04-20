import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/resident_restaurant_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/all%20Restaurants/resident_restaurant_body.dart';

class ResidentRestaurantView extends StatefulWidget {
  const ResidentRestaurantView({super.key});

  @override
  State<ResidentRestaurantView> createState() => _ResidentRestaurantViewState();
}

class _ResidentRestaurantViewState extends State<ResidentRestaurantView> {
  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('allRestaurants'.tr(context))),
      body: BlocStatusHandler<ResidentRestaurantCubit, ResidentRestaurantState>(
        body: const ResidentRestaurantBody(),
        onRetry: () {
          getData();
          context.read<ResidentRestaurantCubit>().onRetry();
        },
        isNetwork: (state) => state is ResidentRestaurantNetworkState,
        isError: (state) => state is ResidentRestaurantFailureState,
        buildWhen: (previous, current) =>
            current is ResidentRestaurantNetworkState ||
            current is ResidentRestaurantFailureState ||
            current is ResidentRestaurantOnRetryState,
      ),
    );
  }

  void getData() {
    final cubit = context.read<ResidentRestaurantCubit>();
    cubit.getRestaurantCategories();
    cubit.getRestaurantsByCategory(fromPagination: false);
  }
}

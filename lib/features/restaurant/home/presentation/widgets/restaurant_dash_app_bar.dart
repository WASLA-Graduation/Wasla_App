import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/custom_home_app_bar.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';
import 'package:wasla/features/restaurant/home/presentation/manager/cubit/restaurant_dashboard_cubit.dart';

class RestaurantDashboardAppBar extends StatefulWidget {
  const RestaurantDashboardAppBar({super.key});

  @override
  State<RestaurantDashboardAppBar> createState() =>
      _RestaurantDashboardAppBarState();
}

class _RestaurantDashboardAppBarState extends State<RestaurantDashboardAppBar> {
  RestaurantModel? restaurant;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantDashboardCubit, RestaurantDashboardState>(
      buildWhen: (prev, current) =>
          current is RestaurantDashboardGetDataSuccessState,
      builder: (context, state) {
        if (state is RestaurantDashboardGetDataSuccessState) {
          restaurant = state.restaurant;
        }
        return CustomHomeAppBar(
          isLoading: restaurant == null,
          userName: restaurant?.ownerName,
          imageUrl: restaurant?.profile,
          onBookmarkTap: () {},
          showBookmark: false,
        );
      },
    );
  }
}

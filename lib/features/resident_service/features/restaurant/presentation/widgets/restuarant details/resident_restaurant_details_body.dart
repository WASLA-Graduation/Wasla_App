import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/details/resident_restaurant_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/restuarant%20details/resident_restaurant_details_widget.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class ResidentRestaurantDetailsBody extends StatefulWidget {
  const ResidentRestaurantDetailsBody({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  State<ResidentRestaurantDetailsBody> createState() =>
      _ResidentRestaurantDetailsBodyState();
}

class _ResidentRestaurantDetailsBodyState
    extends State<ResidentRestaurantDetailsBody> {
  RestaurantModel? restaurant;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentRestaurantCubit, ResidentRestaurantState>(
      buildWhen: (previous, current) =>
          current is ResidentRestaurantDashboardGetDataLoadingState ||
          current is ResidentRestaurantDashboardGetDataSuccessState,
      builder: (context, state) {
        if (state is ResidentRestaurantDashboardGetDataLoadingState ||
            state is ResidentRestaurantInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is ResidentRestaurantDashboardGetDataSuccessState) {
          restaurant = state.restaurant;
        }

        return ResidentRestaurantDetailsWidget(
          restaurant: restaurant!,
          restaurantId: widget.restaurantId,
        );
      },
    );
  }
}

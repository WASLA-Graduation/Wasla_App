import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/resident_restaurant_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/restuarant%20details/resident_restaurant_details_body.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class ResidentRestaurantDetailsView extends StatefulWidget {
  const ResidentRestaurantDetailsView({super.key, required this.data});
  final Map<String, dynamic> data;

  @override
  State<ResidentRestaurantDetailsView> createState() =>
      _ResidentRestaurantDetailsViewState();
}

class _ResidentRestaurantDetailsViewState
    extends State<ResidentRestaurantDetailsView> {
  @override
  void initState() {
    super.initState();
    getScreenData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.data[AppStrings.name])),
      body: BlocStatusHandler<ResidentRestaurantCubit, ResidentRestaurantState>(
        body: ResidentRestaurantDetailsBody(
          restaurantId: widget.data[AppStrings.id],
        ),
        onRetry: () {
          getScreenData();
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

  void getScreenData() {
    final cubit = context.read<ResidentRestaurantCubit>();
    final review = context.read<ReviewsCubit>();
    cubit.getRestaurantDetails(restaurantId: widget.data[AppStrings.id]);
    review.resetState();
    review.getReveiws(widget.data[AppStrings.id]);
    review.selectedUserId = widget.data[AppStrings.id];
  }
}

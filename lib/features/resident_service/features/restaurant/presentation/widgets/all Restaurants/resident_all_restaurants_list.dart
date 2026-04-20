import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/details/resident_restaurant_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/all%20Restaurants/resident_all_restaurants_pagination_list.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class ResidentAllRestaurantsList extends StatefulWidget {
  const ResidentAllRestaurantsList({super.key});

  @override
  State<ResidentAllRestaurantsList> createState() =>
      _ResidentAllRestaurantsListState();
}

class _ResidentAllRestaurantsListState
    extends State<ResidentAllRestaurantsList> {
  List<RestaurantModel> restaurants = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentRestaurantCubit, ResidentRestaurantState>(
      buildWhen: (previous, current) =>
          current is GetRestaurantsByCategorieLoadingState ||
          current is GetRestaurantsByCategoryLoadedState,
      builder: (context, state) {
        if (state is GetRestaurantsByCategorieLoadingState ||
            state is ResidentRestaurantInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is GetRestaurantsByCategoryLoadedState) {
          restaurants = state.restaurants;
        }

        return restaurants.isEmpty
            ? EmptyStateWidget(
                message: 'noRestaurantsInSystem'.tr(context),
                title: 'noRestaurants'.tr(context),
              )
            : ResidentAllRestaurantsPaginationList(restaurants: restaurants);
      },
    );
  }
}

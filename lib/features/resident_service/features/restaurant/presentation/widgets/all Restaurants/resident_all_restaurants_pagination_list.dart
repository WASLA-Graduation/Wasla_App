import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/resident_restaurant_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/all%20Restaurants/resident_restaruant_pag_item.dart';
import 'package:wasla/features/restaurant/home/data/models/restaurant_model.dart';

class ResidentAllRestaurantsPaginationList extends StatelessWidget {
  const ResidentAllRestaurantsPaginationList({
    super.key,
    required this.restaurants,
  });

  final List<RestaurantModel> restaurants;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentRestaurantCubit>();
    return PaginationListener(
      onLoadMore: () async {
        cubit.getRestaurantsByCategory(fromPagination: true);
      },
      child: Column(
        children: [
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 14),
              physics: const BouncingScrollPhysics(),
              itemCount: restaurants.length,
              itemBuilder: (context, index) => InkWell(
                onTap: () {
                  context.pushScreen(
                    AppRoutes.residentRestaurantDetailsScreen,
                    arguments: {
                      AppStrings.name: restaurants.elementAt(index).name,
                      AppStrings.id: restaurants.elementAt(index).id,
                    },
                  );
                },
                child: ResidentRestaruantPagItem(
                  withFav: true,
                  index: index,
                  restaurant: restaurants.elementAt(index),
                ),
              ),
            ),
          ),

          BlocBuilder<ResidentRestaurantCubit, ResidentRestaurantState>(
            builder: (context, state) {
              return state
                      is GetRestaurantsByCategorieFromPaginationLoadingState
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

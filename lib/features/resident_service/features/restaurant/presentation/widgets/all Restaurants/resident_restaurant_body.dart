import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/all%20Restaurants/resident_all_restaurants_list.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/all%20Restaurants/resident_restaurant_category.dart';

class ResidentRestaurantBody extends StatelessWidget {
  const ResidentRestaurantBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: Column(
        children: [
          SizedBox(height: AppSizes.paddingSizeSmall),
          const ResidnetRestaurantCategory(),
          SizedBox(height: AppSizes.paddingSizeDefault),
          Expanded(child: const ResidentAllRestaurantsList()),
          SizedBox(height: AppSizes.paddingSizeDefault),
        ],
      ),
    );
  }
}

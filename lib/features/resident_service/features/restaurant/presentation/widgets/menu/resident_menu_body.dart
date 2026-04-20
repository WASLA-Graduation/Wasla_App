import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/menu/menu_category.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/menu/restaurant_menu_category_list.dart';

class ResidentMenuBody extends StatelessWidget {
  const ResidentMenuBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: Column(
        children: [
          SizedBox(height: AppSizes.paddingSizeSmall),
          const ResidnetRestaurantMenuCategory(),
          SizedBox(height: AppSizes.paddingSizeDefault),
          Expanded(child: RestaurantMenuCatgoryList(showOrderButton: true)),
          SizedBox(height: AppSizes.paddingSizeDefault),
        ],
      ),
    );
  }
}

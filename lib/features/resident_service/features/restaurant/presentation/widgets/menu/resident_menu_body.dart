import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/menu/menu_category.dart';

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
          // Expanded(child: const ResidentAllRestaurantsList()),
          SizedBox(height: AppSizes.paddingSizeDefault),
        ],
      ),
    );
  }
}

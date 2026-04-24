import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/restaurant/home/presentation/widgets/restaurant_dash_app_bar.dart';
import 'package:wasla/features/restaurant/home/presentation/widgets/restaurant_statistics.dart';

class RestaurantDashboardBody extends StatelessWidget {
  const RestaurantDashboardBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppSizes.marginDefault,
        vertical: AppSizes.paddingSizeExtraSmall,
      ),

      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: const RestaurantDashboardAppBar()),
          SliverToBoxAdapter(
            child: SizedBox(height: AppSizes.paddingSizeExtraSmall),
          ),
          RestaurantStatistics(),
        ],
      ),
    );
  }
}

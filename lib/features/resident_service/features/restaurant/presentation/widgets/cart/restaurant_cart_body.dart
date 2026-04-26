import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/cart/restaurant_cart_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/cart/restaurant_cart_list.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/cart/restaurnt_checkout_widget.dart';

class RestaurantCartBody extends StatelessWidget {
  const RestaurantCartBody({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
            child: const RestauantCartList(),
          ),
        ),
        const SizedBox(height: 10),
        RestaurantCheckoutWiget(
          restaurantId: restaurantId,
          onTap: () {
            if (context.read<RestaurantCartCubit>().cartList.isNotEmpty) {
              context.pushScreen(
                AppRoutes.restaurantCheckoutScreen,
                arguments: {
                  AppStrings.id: restaurantId,
                  AppStrings.cubit: context.read<RestaurantCartCubit>(),
                },
              );
            }
          },
        ),
      ],
    );
  }
}

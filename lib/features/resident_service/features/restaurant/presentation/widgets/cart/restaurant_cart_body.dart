import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/cart/restaurant_cart_list.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/cart/restaurnt_checkout_widget.dart';

class RestaurantCartBody extends StatelessWidget {
  const RestaurantCartBody({super.key});

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
        const RestaurantCheckoutWiget(),
      ],
    );
  }
}

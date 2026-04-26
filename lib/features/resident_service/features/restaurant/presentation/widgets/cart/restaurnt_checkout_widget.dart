import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/cart/restaurant_cart_cubit.dart';

class RestaurantCheckoutWiget extends StatelessWidget {
  const RestaurantCheckoutWiget({
    super.key,
    required this.restaurantId,
    required this.onTap,
  });
  final String restaurantId;

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.2)
            : AppColors.whiteColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 25,
        children: [
          Row(
            children: [
              Text(
                'totalCost'.tr(context),
                style: Theme.of(context).textTheme.headlineMedium,
              ),

              Expanded(
                child: BlocBuilder<RestaurantCartCubit, RestaurantCartState>(
                  builder: (context, state) {
                    return Text(
                      textAlign: TextAlign.end,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      '${context.read<RestaurantCartCubit>().calcTotalCost} ${"egb".tr(context)}',
                      style: Theme.of(context).textTheme.headlineMedium,
                    );
                  },
                ),
              ),
            ],
          ),
          BlocBuilder<RestaurantCartCubit, RestaurantCartState>(
            buildWhen: (previous, current) =>
                context.read<RestaurantCartCubit>().cartList.isEmpty ||
                current is RestaurantCartCheckoutState ||
                current is RestaurantGetCartLoadedState,
            builder: (context, state) {
              return GeneralButton(
                color: context.read<RestaurantCartCubit>().cartList.isEmpty
                    ? AppColors.grayDark
                    : AppColors.primaryColor,
                onPressed: onTap,
                text: state is RestaurantCartCheckoutLoadingState
                    ? 'loading'.tr(context)
                    : 'checkout'.tr(context),
              );
            },
          ),
        ],
      ),
    );
  }
}

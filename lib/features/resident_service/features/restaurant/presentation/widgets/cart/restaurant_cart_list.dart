import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restaurant_cart_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/cart/restaurant_cart_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/cart/restauarant_cart_list_item.dart';

class RestauantCartList extends StatefulWidget {
  const RestauantCartList({super.key});

  @override
  State<RestauantCartList> createState() => _RestauantCartListState();
}

class _RestauantCartListState extends State<RestauantCartList> {
  List<RestaurantCartModel> cart = [];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCartCubit, RestaurantCartState>(
      buildWhen: (previous, current) =>
          current is RestaurantGetCartLoadingState ||
          current is RestaurantGetCartLoadedState,
      builder: (context, state) {
        if (state is RestaurantGetCartLoadingState ||
            state is RestaurantCartInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is RestaurantGetCartLoadedState) {
          cart = state.cart;
        }

        return cart.isEmpty
            ? EmptyStateWidget(
                message: 'noMenusInCart'.tr(context),
                title: 'addMenusToCart'.tr(context),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: EdgeInsets.zero,
                itemCount: cart.length,
                itemBuilder: (context, index) =>
                    RestaurantCartListItem(item: cart[index]),
              );
      },
    );
  }
}

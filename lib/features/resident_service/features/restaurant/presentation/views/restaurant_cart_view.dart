import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/cart/restaurant_cart_cubit.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/cart/restaurant_cart_body.dart';

class RestaurantCartView extends StatefulWidget {
  const RestaurantCartView({super.key, required this.restaurantId});
  final String restaurantId;

  @override
  State<RestaurantCartView> createState() => _RestaurantCartViewState();
}

class _RestaurantCartViewState extends State<RestaurantCartView> {
  @override
  void initState() {
    super.initState();
    getMyCart();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('myCart'.tr(context))),
      body: BlocStatusHandler<RestaurantCartCubit, RestaurantCartState>(
        body: RestaurantCartBody(restaurantId: widget.restaurantId),
        onRetry: () {
          getMyCart();
          context.read<RestaurantCartCubit>().onRetry();
        },
        isNetwork: (state) => state is RestaurantCartNetworkState,
        isError: (state) => state is RestaurantCartFailureState,
        buildWhen: (previous, current) =>
            current is RestaurantCartNetworkState ||
            current is RestaurantCartFailureState ||
            current is RestaurantCartOnRetryState,
      ),
    );
  }

  void getMyCart() {
    final cubit = context.read<RestaurantCartCubit>();
    cubit.getMyCart(restaurantId: widget.restaurantId);
  }
}

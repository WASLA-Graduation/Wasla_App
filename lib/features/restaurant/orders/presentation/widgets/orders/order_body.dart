import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_order_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/restaurant_orders_list.dart';

class OrderBody extends StatefulWidget {
  const OrderBody({super.key});

  @override
  State<OrderBody> createState() => _OrderBodyState();
}

class _OrderBodyState extends State<OrderBody> {
  List<OrderModel> orders = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: BlocBuilder<OrdersCubit, OrdersState>(
        buildWhen: (previous, current) =>
            current is GetRestaurantOrdersLoadingState ||
            current is GetRestaurantOrdersLoadedState,
        builder: (context, state) {
          if (state is GetRestaurantOrdersLoadingState ||
              state is OrdersInitial) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50.0,
              ),
            );
          } else if (state is GetRestaurantOrdersLoadedState) {
            orders=state.orders;
          }

          return orders.isEmpty
              ? EmptyStateWidget(
                  title: 'noOrders'.tr(context),
                  message: 'noOrdersAtTheMoment'.tr(context),
                )
              : RestaurantPaginationOrdersList(orders: orders);
        },
      ),
    );
  }
}

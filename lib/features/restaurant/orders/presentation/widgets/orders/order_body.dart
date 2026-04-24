import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/pagination_bloc_list.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/features/restaurant/orders/data/model/order_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_item_widget.dart';

class OrderBody extends StatelessWidget {
  const OrderBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: PaginatedBlocList<OrderModel, OrdersCubit, OrdersState>(
        buildWhen: (previous, current) =>
            current is GetRestaurantOrdersLoadingState ||
            current is GetRestaurantOrdersLoadedState,

        isLoading: (state) =>
            state is GetRestaurantOrdersLoadingState || state is OrdersInitial,

        isPaginationLoading: (state) =>
            state is GetRestaurantOrdersFromPaginationLoadingState,

        onData: (state) {
          if (state is GetRestaurantOrdersLoadedState) {
            return state.orders;
          }
          return [];
        },
        isData: (state) => state is GetRestaurantOrdersLoadedState,
        itemBuilder: (order, index) {
          return OrderItem(order: order, onCancel: () {}, onConfirm: () {});
        },

        onLoadMore: () async {
          context.read<OrdersCubit>().getRestaurantsOrders(
            fromPagination: true,
          );
        },
        emptyTitle: 'noOrders'.tr(context),
        emptyMessage: 'noOrdersAtTheMoment'.tr(context),
      ),
    );
  }
}

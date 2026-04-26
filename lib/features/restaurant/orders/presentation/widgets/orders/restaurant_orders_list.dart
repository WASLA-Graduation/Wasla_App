import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_order_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_item_widget.dart';

class RestaurantPaginationOrdersList extends StatelessWidget {
  const RestaurantPaginationOrdersList({super.key, required this.orders});

  final List<OrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return PaginationListener(
      onLoadMore: () async {
        context.read<OrdersCubit>().getRestaurantsOrders(fromPagination: true);
      },
      child: Column(
        children: [
          SizedBox(height: AppSizes.paddingSizeEight),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (context, index) => const SizedBox(height: 5),
              physics: const BouncingScrollPhysics(),
              itemCount: orders.length,
              itemBuilder: (context, index) =>
                  OrderItem(order: orders.elementAt(index), withButtons: true),
            ),
          ),

          BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              return state is GetRestaurantOrdersFromPaginationLoadingState
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/restaurant/orders/data/model/resident_order_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_item_widget.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';

class ResidentOrdersPaginationList extends StatelessWidget {
  const ResidentOrdersPaginationList({super.key, required this.orders});

  final List<ResidentOrderModel> orders;

  @override
  Widget build(BuildContext context) {
    return PaginationListener(
      onLoadMore: () async {
        context.read<OrdersCubit>().getResidentOrders(fromPagination: true);
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
                  OrderItem(order: orders.elementAt(index), withButtons: false),
            ),
          ),

          BlocBuilder<OrdersCubit, OrdersState>(
            builder: (context, state) {
              return state is GetOrdersForResidetntFromPaginationLoadingState
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

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/restaurant/orders/data/model/base_order_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_buttons_wiget.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_item_header.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_items_section.dart';

import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_totals_section.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order,required this.withButtons});

  final BaseOrderModel order;
  final bool withButtons;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: context.isDarkMode
            ? AppColors.blackColor.withOpacity(0.2)
            : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderHeader(
            order: order,
            formatedDate: formateDateToMatchWithPosts(order.createdAt),
          ),

          BlocBuilder<OrdersCubit, OrdersState>(
            buildWhen: (previous, current) =>
                current is ShowOrderDetails && current.orderId == order.id,
            builder: (context, state) {
              return Visibility(
                visible: context.read<OrdersCubit>().isOrderDetailsVisible(
                  orderId: order.id,
                ),
                child: Column(
                  children: [
                    const Divider(height: 0, thickness: 0.5),
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: OrderItemsSection(items: order.items),
                    ),

                    const Divider(height: 0, thickness: 0.5),

                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: _DeliverySection(order: order),
                    ),

                    const Divider(height: 0, thickness: 0.5),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 14, 16, 14),
                      child: OrderTotalsSection(order: order),
                    ),

                    const Divider(height: 20, thickness: 0.5),

                    OrderButtons(order: order, withButtons: withButtons),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}



class _DeliverySection extends StatelessWidget {
  const _DeliverySection({required this.order});

  final BaseOrderModel order;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'delivery'.tr(context).toUpperCase(),
          style: const TextStyle(
            fontSize: 11,
            letterSpacing: 0.9,
            fontWeight: FontWeight.w500,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.location_on_outlined,
              size: 16,
              color: Colors.grey,
            ),
            const SizedBox(width: 6),
            Expanded(
              child: Text(
                order.address,
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Colors.grey[600],
                ),
              ),
            ),
          ],
        ),
        if (order.notes.isNotEmpty) ...[
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(8),
            ),
            child: Text(
              '"${order.notes}"',
              style: Theme.of(context).textTheme.labelSmall?.copyWith(
                fontWeight: FontWeight.w400,
                fontStyle: FontStyle.italic,
                color: Colors.grey[600],
                fontSize: 12,
              ),
            ),
          ),
        ],
      ],
    );
  }
}

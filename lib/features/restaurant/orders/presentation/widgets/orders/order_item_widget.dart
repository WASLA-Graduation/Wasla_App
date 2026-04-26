import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/restaurant/orders/data/model/base_order_model.dart';
import 'package:wasla/features/restaurant/orders/data/model/resident_order_model.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_order_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_buttons_wiget.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_items_section.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_status_badge.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_totals_section.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({super.key, required this.order, this.withButtons});

  final BaseOrderModel order;
  final bool? withButtons;

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

                    const Divider(height: 0, thickness: 0.5),

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

class OrderHeader extends StatelessWidget {
  const OrderHeader({
    super.key,
    required this.order,
    required this.formatedDate,
  });

  final BaseOrderModel order;
  final String formatedDate;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(18, 18, 18, 14),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'order'.tr(context),
                      style: const TextStyle(
                        fontSize: 11,
                        letterSpacing: 0.9,
                        color: Colors.grey,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '#${order.id}',
                      style: Theme.of(context).textTheme.displaySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 22,
                      ),
                    ),
                  ],
                ),
              ),
              OrderStatusBadge(status: order.status.index),
              InkWell(
                onTap: () {
                  context.read<OrdersCubit>().toggleOrderDetails(
                    orderId: order.id,
                  );
                },
                child: Transform.translate(
                  offset: const Offset(12, 0),
                  child: Icon(
                    Icons.keyboard_arrow_down_rounded,
                    size: 30,
                    color: context.isDarkMode ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: _MetaItem(
                  label: isRestaurantOrder
                      ? 'customer'.tr(context)
                      : 'restaurant'.tr(context),
                  value: isRestaurantOrder
                      ? (order as OrderModel).residentName
                      : (order as ResidentOrderModel).restaurantName,
                ),
              ),

              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: _MetaItem(
                    label: 'date'.tr(context),
                    value: formatedDate,
                  ),
                ),
              ),
              if (isRestaurantOrder)
                Expanded(
                  flex: 1,
                  child: _MetaItem(
                    label: 'phone'.tr(context),
                    value: (order as OrderModel).residentPhone,
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  bool get isRestaurantOrder => order is OrderModel;
}

class _MetaItem extends StatelessWidget {
  const _MetaItem({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          label,
          style: const TextStyle(fontSize: 11, color: Colors.grey),
        ),
        const SizedBox(height: 2),
        Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          value,
          style: Theme.of(
            context,
          ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w500),
        ),
      ],
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

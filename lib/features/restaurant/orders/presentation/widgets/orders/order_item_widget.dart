import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/restaurant/orders/data/model/order_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_actions.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_items_section.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_status_badge.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_totals_section.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    super.key,
    required this.order,
    required this.onCancel,
    required this.onConfirm,
  });

  final OrderModel order;
  final VoidCallback onCancel;
  final VoidCallback onConfirm;

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
          _OrderHeader(
            order: order,
            paymentLabel: 'card',
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

                    Padding(
                      padding: const EdgeInsets.all(14),
                      child: OrderActions(
                        onCancel: onCancel,
                        onConfirm: onConfirm,
                      ),
                    ),
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

class _OrderHeader extends StatelessWidget {
  const _OrderHeader({
    required this.order,
    required this.paymentLabel,
    required this.formatedDate,
  });

  final OrderModel order;
  final String paymentLabel;
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
              OrderStatusBadge(status: order.status),
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
              _MetaItem(
                label: 'customer'.tr(context),
                value: order.residentName,
              ),
              const SizedBox(width: 20),
              _MetaItem(label: 'date'.tr(context), value: formatedDate),
              const SizedBox(width: 20),
              _MetaItem(
                label: 'payment'.tr(context),
                value: paymentLabel.tr(context),
              ),
            ],
          ),
        ],
      ),
    );
  }
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
        Text(label, style: const TextStyle(fontSize: 11, color: Colors.grey)),
        const SizedBox(height: 2),
        Text(
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

  final OrderModel order;

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

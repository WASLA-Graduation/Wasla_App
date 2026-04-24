import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/restaurant/orders/data/model/order_model.dart';

class OrderItemsSection extends StatelessWidget {
  const OrderItemsSection({super.key, required this.items});

  final List<OrderItemModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionTitle(label: 'items'.tr(context)),
        const SizedBox(height: 10),
        ...items.asMap().entries.map((entry) {
          final isLast = entry.key == items.length - 1;
          return _OrderItemRow(item: entry.value, isLast: isLast);
        }),
      ],
    );
  }
}

class _OrderItemRow extends StatelessWidget {
  const _OrderItemRow({required this.item, required this.isLast});

  final OrderItemModel item;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 7),
          child: Row(
            children: [
              _QtyBadge(qty: item.quantity),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  item.orderItemName,
                  style: Theme.of(
                    context,
                  ).textTheme.labelSmall?.copyWith(fontWeight: FontWeight.w400),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Text(
                'EGP ${(item.price * item.quantity).toStringAsFixed(0)}',
                style: Theme.of(context).textTheme.labelSmall?.copyWith(
                  color: Theme.of(context).textTheme.titleSmall?.color,
                ),
              ),
            ],
          ),
        ),
        if (!isLast) const Divider(height: 0, thickness: 0.5),
      ],
    );
  }
}

class _QtyBadge extends StatelessWidget {
  const _QtyBadge({required this.qty});

  final int qty;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 22,
      height: 22,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(6),
      ),
      alignment: Alignment.center,
      child: Text(
        '$qty',
        style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w500),
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label.toUpperCase(),
      style: const TextStyle(
        fontSize: 11,
        letterSpacing: 0.08 * 11,
        fontWeight: FontWeight.w500,
        color: Colors.grey,
      ),
    );
  }
}

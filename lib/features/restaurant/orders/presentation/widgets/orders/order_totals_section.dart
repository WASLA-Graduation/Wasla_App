import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/restaurant/orders/data/model/base_order_model.dart';

class OrderTotalsSection extends StatelessWidget {
  const OrderTotalsSection({super.key, required this.order});

  final BaseOrderModel order;

  double get _subtotal =>
      order.items.fold(0, (sum, i) => sum + (i.price * i.quantity));

  @override
  Widget build(BuildContext context) {
    final textSecondary = Theme.of(context).textTheme.titleSmall;
    final textPrimary = Theme.of(context).textTheme.labelSmall;

    return Column(
      children: [
        _TotalRow(
          label: 'subtotal'.tr(context),
          value: 'EGP ${_subtotal.toStringAsFixed(0)}',
          style: textSecondary,
        ),
        const SizedBox(height: 4),
        _TotalRow(
          label: 'deliveryFee'.tr(context),
          value: 'EGP ${order.deliveryFee.toStringAsFixed(0)}',
          style: textSecondary,
        ),
        const SizedBox(height: 10),
        const Divider(height: 0, thickness: 0.5),
        const SizedBox(height: 10),
        _TotalRow(
          label: 'total'.tr(context),
          value: 'EGP ${order.totalPrice.toStringAsFixed(0)}',
          style: textPrimary?.copyWith(fontWeight: FontWeight.w600),
          isGrand: true,
        ),
      ],
    );
  }
}

class _TotalRow extends StatelessWidget {
  const _TotalRow({
    required this.label,
    required this.value,
    this.style,
    this.isGrand = false,
  });

  final String label;
  final String value;
  final TextStyle? style;
  final bool isGrand;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(label, style: style),
        Text(value, style: style),
      ],
    );
  }
}

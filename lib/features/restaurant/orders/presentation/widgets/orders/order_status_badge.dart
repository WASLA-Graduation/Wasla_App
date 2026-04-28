import 'package:flutter/material.dart';
import 'package:wasla/core/enums/restauant_reservation_status.dart';
import 'package:wasla/core/utils/app_colors.dart';

class OrderStatusBadge extends StatelessWidget {
  const OrderStatusBadge({super.key, required this.status});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            width: 6,
            height: 6,
            decoration: BoxDecoration(
              color: AppColors.orange,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 5),
          Text(
            status.name,
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.orange),
          ),
        ],
      ),
    );
  }
}

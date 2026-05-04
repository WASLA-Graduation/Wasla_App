import 'package:flutter/material.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/payment/data/models/base_payment_model.dart';
import 'package:wasla/features/payment/presentation/widgets/payment_item.dart';

class PaymentList extends StatelessWidget {
  const PaymentList({super.key, required this.payments});

  final List<BasePaymentModel> payments;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: payments.length,
      separatorBuilder: (context, index) =>
          Divider(color: AppColors.gray, thickness: 0.3, height: 20),
      itemBuilder: (context, index) => PaymentItem(payment: payments[index]),
    );
  }
}

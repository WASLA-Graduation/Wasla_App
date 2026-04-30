import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_credit_card_widget.dart';

class PaymentMethodSelector extends StatelessWidget {
  const PaymentMethodSelector({
    super.key,
    required this.groupValue,
    required this.onChanged,
  });

  final PaymentMethod groupValue;
  final ValueChanged<PaymentMethod> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomCreditCard(
          image: Assets.assetsImagesCash,
          groupValue: groupValue,
          value: PaymentMethod.cash,
          label: 'cashPayment'.tr(context),
          onChanged: (value) {
            if (value != null) {
              onChanged(PaymentMethod.cash);
            }
          },
        ),
        const SizedBox(height: 15),
        CustomCreditCard(
          image: Assets.assetsImagesCreditCardpng,
          groupValue: groupValue,
          value: PaymentMethod.creditCard,
          label: 'creditCard'.tr(context),
          onChanged: (value) {
            if (value != null) {
              onChanged(PaymentMethod.creditCard);
            }
          },
        ),
      ],
    );
  }
}
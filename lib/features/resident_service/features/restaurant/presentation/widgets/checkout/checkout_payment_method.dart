import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/custom_credit_card_widget.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/manager/cubit/cart/restaurant_cart_cubit.dart';

class CheckoutPaymentMethodWidget extends StatelessWidget {
  const CheckoutPaymentMethodWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RestaurantCartCubit, RestaurantCartState>(
      buildWhen: (previous, current) =>
          current is RestaurantUpdatePaymentStauts,
      builder: (context, state) {
        final cubit = context.read<RestaurantCartCubit>();
        return Column(
          children: [
            CustomCreditCard(
              image: Assets.assetsImagesCash,
              groupValue: cubit.paymentMethod,
              value: PaymentMethod.cash,
              label: 'cashPayment'.tr(context),
              onChanged: (value) {
                if (value != null) {
                  cubit.changePaymentMethod(PaymentMethod.cash);
                }
              },
            ),
            SizedBox(height: AppSizes.paddingSizeFifteen),
            CustomCreditCard(
              image: Assets.assetsImagesCreditCardpng,
              groupValue: cubit.paymentMethod,
              value: PaymentMethod.creditCard,
              label: 'creditCard'.tr(context),
              onChanged: (value) {
                if (value != null) {
                  cubit.changePaymentMethod(
                    PaymentMethod.creditCard,
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }
}

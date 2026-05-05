import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/widgets/custom_radio_button_list.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';

class GymBookingBottomSheet extends StatelessWidget {
  const GymBookingBottomSheet({
    super.key,
    required this.bookingId,
    required this.price,
  });
  final int bookingId;
  final int price;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymResidentCubit>();
    return Container(
      padding: EdgeInsets.all(16),
      width: double.infinity,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(40),
          topRight: Radius.circular(40),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        spacing: 8,
        children: [
          UnderLineWidget(),
          _buildTextWidget(context),
          CustomRadioList<PaymentMethod>(
            values: PaymentMethod.values
                .where((m) => m != PaymentMethod.wallet)
                .toList(),
            groupValue: cubit.paymentMethod,
            onChanged: (value) async {
              cubit.paymentMethod = value;
              context.pop();
              await cubit.bookAtGym(
                bookingId: bookingId,
                gymId: cubit.selecedGymId,
                amount: price,
              );
            },
            titleBuilder: (value) {
              return value.name.tr(context);
            },
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Text _buildTextWidget(BuildContext context) => Text(
    "paymentMethod".tr(context),
    style: Theme.of(context).textTheme.headlineMedium!,
  );
}

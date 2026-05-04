import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/payment/data/models/base_payment_model.dart';
import 'package:wasla/features/payment/presentation/manager/cubit/payment_cubit.dart';
import 'package:wasla/features/payment/presentation/widgets/payment_list.dart';

class PaymentBody extends StatefulWidget {
  const PaymentBody({super.key});

  @override
  State<PaymentBody> createState() => _PaymentBodyState();
}

class _PaymentBodyState extends State<PaymentBody> {
  List<BasePaymentModel> payments = [];
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: BlocBuilder<PaymentCubit, PaymentState>(
        buildWhen: (previous, current) =>
            current is GetPaymentLoadingState ||
            current is GetPaymentLoadedState,
        builder: (context, state) {
          if (state is GetPaymentLoadingState || state is PaymentInitial) {
            return Center(
              child: SpinKitFadingCircle(
                color: AppColors.primaryColor,
                size: 50.0,
              ),
            );
          } else if (state is GetPaymentLoadedState) {
            payments = state.payments;
          }

          return payments.isEmpty
              ? EmptyStateWidget(
                  title: 'noPaymentTitle'.tr(context),
                  message: 'noPaymentDesc'.tr(context),
                )
              : PaymentList(payments: payments);
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/payment/presentation/manager/cubit/payment_cubit.dart';
import 'package:wasla/features/payment/presentation/widgets/payment_body.dart';

class PaymentView extends StatefulWidget {
  const PaymentView({super.key});

  @override
  State<PaymentView> createState() => _PaymentViewState();
}

class _PaymentViewState extends State<PaymentView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('payment'.tr(context))),
      body: BlocStatusHandler<PaymentCubit, PaymentState>(
        body: const PaymentBody(),
        onRetry: () {
          context.read<PaymentCubit>().onRetry();
          getMyPayments();
        },
        isNetwork: (state) => state is PaymentNetworkState,
        isError: (state) => state is PaymentFailureState,
        buildWhen: (previous, current) =>
            current is PaymentNetworkState ||
            current is PaymentFailureState ||
            current is PaymentOnRetryState,
      ),
    );
  }

  void getMyPayments() {}
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_body.dart';

class OrderView extends StatefulWidget {
  const OrderView({super.key});

  @override
  State<OrderView> createState() => _OrderViewState();
}

class _OrderViewState extends State<OrderView> {
  @override
  void initState() {
    super.initState();
    getOrders();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('orders'.tr(context))),
      body: BlocStatusHandler<OrdersCubit, OrdersState>(
        body: const OrderBody(),
        onRetry: () {
          getOrders();
          context.read<OrdersCubit>().onRetry();
        },
        isNetwork: (state) => state is OrdersNetworkState,
        isError: (state) => state is OrdersFailureState,
        buildWhen: (previous, current) =>
            current is OrdersNetworkState ||
            current is OrdersFailureState ||
            current is OrdersOnRetryState,
      ),
    );
  }

  void getOrders() {
    final cubit = context.read<OrdersCubit>();
    cubit.getRestaurantsOrders(fromPagination: false);
  }
}

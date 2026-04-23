import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders_body.dart';

class OrdersView extends StatefulWidget {
  const OrdersView({super.key});

  @override
  State<OrdersView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<OrdersView> {
  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('reservation'.tr(context))),
      body: BlocStatusHandler<OrdersCubit, OrdersState>(
        body: const OrdersBody(),
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
    cubit.getRestaurantsReservations(fromPagination: false);
  }
}

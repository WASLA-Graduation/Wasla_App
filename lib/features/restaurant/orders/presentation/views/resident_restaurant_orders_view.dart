import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/resident_orders_body.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';

class ResidentRestaurantOrdersView extends StatefulWidget {
  const ResidentRestaurantOrdersView({super.key});

  @override
  State<ResidentRestaurantOrdersView> createState() =>
      _ResidentRestaurantOrdersViewState();
}

class _ResidentRestaurantOrdersViewState
    extends State<ResidentRestaurantOrdersView> {
  @override
  void initState() {
    getOrders();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('all_orders'.tr(context))),
      body: BlocStatusHandler<OrdersCubit, OrdersState>(
        body: const ResidentRestaurantOrdersBody(),
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
    cubit.getResidentOrders(fromPagination: false);
  }
}

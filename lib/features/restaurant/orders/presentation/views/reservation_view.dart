import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/reservations/reservation_body.dart';

class ReservationView extends StatefulWidget {
  const ReservationView({super.key});

  @override
  State<ReservationView> createState() => _OrdersViewState();
}

class _OrdersViewState extends State<ReservationView> {
  @override
  void initState() {
    getReservations();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('reservation'.tr(context)),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppSizes.marginDefault),
            child: IconButton(
              icon: Image.asset(
                Assets.assetsImagesTakeAway,
                color: AppColors.primaryColor,
                height: 25,
                width: 25,
              ),
              onPressed: () {
                context.pushScreen(AppRoutes.orderScreen);
              },
            ),
          ),
        ],
      ),
      body: BlocStatusHandler<OrdersCubit, OrdersState>(
        body: const ReservationBody(),
        onRetry: () {
          getReservations();
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

  void getReservations() {
    final cubit = context.read<OrdersCubit>();
    cubit.getRestaurantsReservations(fromPagination: false);
  }
}

import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/restauant_reservation_status.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/restaurant/orders/data/model/base_order_model.dart';
import 'package:wasla/features/restaurant/orders/presentation/manager/cubit/orders_cubit.dart';
import 'package:wasla/features/restaurant/orders/presentation/widgets/orders/order_actions.dart';

class OrderButtons extends StatelessWidget {
  const OrderButtons({
    super.key,
    required this.order,
    required this.withButtons,
  });

  final BaseOrderModel order;
  final bool? withButtons;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OrdersCubit, OrdersState>(
      listener: (context, state) {
        if (state is MarkOrderAsDoneFailureState) {
          showToast(state.errorMessage, color: AppColors.red);
        } else if (state is MarkOrderAsPreparedFailureState) {
          showToast(state.errorMessage, color: AppColors.red);
        }
      },
      buildWhen: (previous, current) =>
          current is ChangeOrderStatusState &&
          current.orderId == order.id,
      listenWhen: (previous, current) =>
          current is ChangeOrderStatusState &&
          current.orderId == order.id,
      builder: (context, state) {
        return Visibility(
          visible:
              withButtons ??
              order.status == OrderStatus.pending ||
                  order.status == OrderStatus.preparing,
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: OrderActions(
              onPrepard: () {
                context.read<OrdersCubit>().markOrderAsReady(
                  order: order,
                );
              },
              onConfirm: () {
                context.read<OrdersCubit>().markOrderAsDone(
                  order: order,
                );
              },
              status: order.status,
            ),
          ),
        );
      },
    );
  }
}
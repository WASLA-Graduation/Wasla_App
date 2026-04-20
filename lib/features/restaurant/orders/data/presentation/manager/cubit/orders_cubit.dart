import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/restaurant/orders/data/repo/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.orders) : super(OrdersInitial());
  final OrdersRepo orders;

  void onRetry() {
    emit(OrdersOnRetryState());
  }
}

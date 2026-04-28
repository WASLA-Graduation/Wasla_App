import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/restauant_reservation_status.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/restaurant/orders/data/model/base_order_model.dart';
import 'package:wasla/features/restaurant/orders/data/model/resident_order_model.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_order_model.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_reservation_model.dart';
import 'package:wasla/features/restaurant/orders/data/repo/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.orders) : super(OrdersInitial());
  final OrdersRepo orders;
  final int reservationPageSize = 5;
  int reservationPageNumber = 1;
  bool reservationEndOfPagination = false;
  final int orderPageSize = 5;
  int orderPageNumber = 1;
  bool orderEndOfPagination = false;
  Set oredersIds = {};

  List<OrderModel> restaurantOrders = [];
  List<ResidentOrderModel> residentOrders = [];

  void onRetry() {
    emit(OrdersOnRetryState());
  }

  void toggleOrderDetails({required int orderId}) {
    if (oredersIds.contains(orderId)) {
      oredersIds.remove(orderId);
    } else {
      oredersIds.add(orderId);
    }
    emit(ShowOrderDetails(orderId: orderId));
  }

  bool isOrderDetailsVisible({required int orderId}) =>
      oredersIds.contains(orderId);

  Future<void> getRestaurantsReservations({
    required bool fromPagination,
  }) async {
    if (reservationEndOfPagination ||
        state is GetRestaurantReservationsFromPaginationLoadingState) {
      return;
    }
    if (fromPagination) {
      emit(GetRestaurantReservationsFromPaginationLoadingState());
    } else {
      emit(GetRestaurantReservationsLoadingState());
    }

    final String? restaurantId = await getUserId();

    final result = await orders.getRestaurantReservations(
      pageNumber: reservationPageNumber,
      pageSize: reservationPageSize,
      restaurantId: restaurantId!,
    );

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(OrdersNetworkState());
        } else {
          emit(OrdersFailureState());
        }
      },
      (success) {
        if (success.isEmpty) {
          reservationEndOfPagination = true;
        } else {
          reservationPageNumber++;
        }

        emit(GetRestaurantReservationsLoadedState(reservations: success));
      },
    );
  }

  Future<void> changeReservationStatus({
    required ReservationStatus status,
    required int reservationId,
  }) async {
    final result = await orders.changeReservationStatus(
      status: status.index,
      bookingId: reservationId,
    );
    result.fold(
      (failure) {
        if (ReservationStatus.canceled == status) {
          emit(
            CancelReservationStatusFailureState(
              id: reservationId,
              errorMessage: failure,
            ),
          );
        } else {
          emit(
            AcceptReservationStatusFailureState(
              id: reservationId,
              errorMessage: failure,
            ),
          );
        }
      },
      (success) {
        if (status == ReservationStatus.canceled) {
          emit(CancelReservationStatusSuccessState(id: reservationId));
        } else {
          emit(AcceptReservationStatusSuccessState(id: reservationId));
        }
      },
    );
  }

  Future<void> getRestaurantsOrders({required bool fromPagination}) async {
    if (orderEndOfPagination ||
        state is GetRestaurantOrdersFromPaginationLoadingState) {
      return;
    }
    if (fromPagination) {
      emit(GetRestaurantOrdersFromPaginationLoadingState());
    } else {
      emit(GetRestaurantOrdersLoadingState());
    }

    final String? restaurantId = await getUserId();

    final result = await orders.getOrdersForRestaurant(
      pageNumber: orderPageNumber,
      pageSize: orderPageSize,
      restaurantId: restaurantId!,
    );

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(OrdersNetworkState());
        } else {
          emit(OrdersFailureState());
        }
      },
      (success) {
        if (success.isEmpty) {
          orderEndOfPagination = true;
        } else {
          orderPageNumber++;
        }
        restaurantOrders.addAll(success);
        emit(GetRestaurantOrdersLoadedState(orders: restaurantOrders));
      },
    );
  }

  Future<void> getResidentOrders({required bool fromPagination}) async {
    if (orderEndOfPagination ||
        state is GetOrdersForResidetntFromPaginationLoadingState) {
      return;
    }
    if (fromPagination) {
      emit(GetOrdersForResidetntFromPaginationLoadingState());
    } else {
      emit(GetOrdersForResidetntLoadingState());
    }
    final String? userId = await getUserId();
    final result = await orders.getOrdersForResidnt(
      pageNumber: orderPageNumber,
      pageSize: orderPageSize,
      residentId: userId!,
    );

    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(OrdersNetworkState());
        } else {
          emit(OrdersFailureState());
        }
      },
      (success) {
        if (success.isEmpty) {
          orderEndOfPagination = true;
        } else {
          orderPageNumber++;
        }
        residentOrders.addAll(success);
        emit(GetOrdersForResidetntLoadedState(orders: residentOrders));
      },
    );
  }

  Future<void> markOrderAsDone({required BaseOrderModel order}) async {
    final result = await orders.markOrderAsDelivered(id: order.id);
    result.fold(
      (failure) {
        emit(MarkOrderAsDoneFailureState(errorMessage: failure, id: order.id));
      },
      (success) {
        order.status = OrderStatus.delivered;
        emit(MarkOrderAsDoneSuccessState(id: order.id));
      },
    );
  }

  Future<void> markOrderAsReady({required BaseOrderModel order}) async {
    final result = await orders.markOrderAsPrepared(id: order.id);
    result.fold(
      (failure) {
        emit(
          MarkOrderAsPreparedFailureState(errorMessage: failure, id: order.id),
        );
      },
      (success) {
        order.status = OrderStatus.preparing;
        emit(MarkOrderAsPreparedSuccessState(id: order.id));
      },
    );
  }

  void markOrderAsOnTheWay({required int status, required int orderId}) async {
    final OrderStatus orderStatus = OrderStatus.values[status];
    if (orderStatus == OrderStatus.onTheWay) {
      for (var order in residentOrders) {
        if (order.id == orderId) {
          order.status = OrderStatus.onTheWay;
          break;
        }
      }

      emit(MarkOrderAsOnTheWayState(id: orderId));
    }
  }
}

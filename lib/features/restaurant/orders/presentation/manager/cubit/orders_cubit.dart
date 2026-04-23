import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/restauant_reservation_status.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/restaurant/orders/data/model/restaurant_reservation_model.dart';
import 'package:wasla/features/restaurant/orders/data/repo/orders_repo.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit(this.orders) : super(OrdersInitial());
  final OrdersRepo orders;
  final int pageSize = 10;
  int pageNumber = 1;
  bool endOfPagination = false;

  void onRetry() {
    emit(OrdersOnRetryState());
  }

  Future<void> getRestaurantsReservations({
    required bool fromPagination,
  }) async {
    if (endOfPagination ||
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
      pageNumber: pageNumber,
      pageSize: pageSize,
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
          endOfPagination = true;
        } else {
          pageNumber++;
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
}

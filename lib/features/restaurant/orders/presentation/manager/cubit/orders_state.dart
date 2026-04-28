part of 'orders_cubit.dart';

sealed class OrdersState {
  const OrdersState();
}

final class OrdersInitial extends OrdersState {}

////update states

final class ShowOrderDetails extends OrdersState {
  final int orderId;

  ShowOrderDetails({required this.orderId});
}

////Basics States
final class OrdersFailureState extends OrdersState {}

final class OrdersNetworkState extends OrdersState {}

final class OrdersOnRetryState extends OrdersState {}

////reservation states states
final class GetRestaurantReservationsLoadingState extends OrdersState {}

final class GetRestaurantReservationsFromPaginationLoadingState
    extends OrdersState {}

final class GetRestaurantReservationsLoadedState extends OrdersState {
  final List<RestaurantReservationModel> reservations;

  GetRestaurantReservationsLoadedState({required this.reservations});
}

//////  orders of resident
final class GetOrdersForResidetntLoadingState extends OrdersState {}

final class GetOrdersForResidetntFromPaginationLoadingState
    extends OrdersState {}

final class GetOrdersForResidetntLoadedState extends OrdersState {
  final List<ResidentOrderModel> orders;

  GetOrdersForResidetntLoadedState({required this.orders});
}

////change reservation status states
abstract class ChangeReservationStatusState extends OrdersState {
  final int reservationId;

  ChangeReservationStatusState(this.reservationId);
}

final class AcceptReservationStatusSuccessState
    extends ChangeReservationStatusState {
  final int id;

  AcceptReservationStatusSuccessState({required this.id}) : super(id);
}

final class AcceptReservationStatusFailureState
    extends ChangeReservationStatusState {
  final int id;
  final String errorMessage;

  AcceptReservationStatusFailureState({
    required this.errorMessage,
    required this.id,
  }) : super(id);
}

final class CancelReservationStatusSuccessState
    extends ChangeReservationStatusState {
  final int id;

  CancelReservationStatusSuccessState({required this.id}) : super(id);
}

final class CancelReservationStatusFailureState
    extends ChangeReservationStatusState {
  final int id;
  final String errorMessage;

  CancelReservationStatusFailureState({
    required this.errorMessage,

    required this.id,
  }) : super(id);
}

////order for restauarant states
final class GetRestaurantOrdersLoadingState extends OrdersState {}

final class GetRestaurantOrdersFromPaginationLoadingState extends OrdersState {}

final class GetRestaurantOrdersLoadedState extends OrdersState {
  final List<OrderModel> orders;

  GetRestaurantOrdersLoadedState({required this.orders});
}

////change Order status states
abstract class ChangeOrderStatusState extends OrdersState {
  final int orderId;

  ChangeOrderStatusState(this.orderId);
}

final class MarkOrderAsDoneSuccessState extends ChangeOrderStatusState {
  final int id;

  MarkOrderAsDoneSuccessState({required this.id}) : super(id);
}

final class MarkOrderAsDoneFailureState extends ChangeOrderStatusState {
  final int id;
  final String errorMessage;

  MarkOrderAsDoneFailureState({required this.errorMessage, required this.id})
    : super(id);
}

final class MarkOrderAsPreparedSuccessState extends ChangeOrderStatusState {
  final int id;

  MarkOrderAsPreparedSuccessState({required this.id}) : super(id);
}

final class MarkOrderAsPreparedFailureState extends ChangeOrderStatusState {
  final int id;
  final String errorMessage;

  MarkOrderAsPreparedFailureState({
    required this.errorMessage,
    required this.id,
  }) : super(id);
}

final class MarkOrderAsOnTheWayState extends ChangeOrderStatusState {
  final int id;

  MarkOrderAsOnTheWayState({required this.id}) : super(id);
}

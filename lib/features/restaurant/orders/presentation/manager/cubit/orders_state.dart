part of 'orders_cubit.dart';

sealed class OrdersState {
  const OrdersState();
}

final class OrdersInitial extends OrdersState {}

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

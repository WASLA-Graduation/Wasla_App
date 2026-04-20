part of 'orders_cubit.dart';

sealed class OrdersState  {
  const OrdersState();

}

final class OrdersInitial extends OrdersState {}


////Basics States
final class OrdersFailureState extends OrdersState {}
final class OrdersNetworkState extends OrdersState {}
final class OrdersOnRetryState extends OrdersState {}

part of 'restaurant_cart_cubit.dart';

sealed class RestaurantCartState {
  const RestaurantCartState();
}

final class RestaurantCartInitial extends RestaurantCartState {}

////Basics States
final class RestaurantCartNetworkState extends RestaurantCartState {}

final class RestaurantCartFailureState extends RestaurantCartState {}

final class RestaurantCartOnRetryState extends RestaurantCartState {}

////get my cart States
final class RestaurantGetCartLoadingState extends RestaurantCartState {}

final class RestaurantGetCartLoadedState extends RestaurantCartState {
  final List<RestaurantCartModel> cart;

  RestaurantGetCartLoadedState({required this.cart});
}

///update quantity
final class RestaurantCartUpadteQuantityState extends RestaurantCartState {
  final int itemId;

  RestaurantCartUpadteQuantityState({required this.itemId});
}

///checkout states
final class RestaurantCartCheckoutState extends RestaurantCartState {}

final class RestaurantCartCheckoutLoadingState
    extends RestaurantCartCheckoutState {}

final class RestaurantCartCheckoutSuccessState
    extends RestaurantCartCheckoutState {
  final PaymentModel paymentModel;

  RestaurantCartCheckoutSuccessState({required this.paymentModel});
}

final class RestaurantCartCheckoutFailureState
    extends RestaurantCartCheckoutState {
  final String errMsg;

  RestaurantCartCheckoutFailureState({required this.errMsg});
}

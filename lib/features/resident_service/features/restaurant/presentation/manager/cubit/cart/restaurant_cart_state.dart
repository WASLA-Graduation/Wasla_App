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
final class RestaurantCartUpateQuantityState extends RestaurantCartState {
  final int itemId;

  RestaurantCartUpateQuantityState({required this.itemId});
}

////remove cart States
abstract final class RestaurantRemoveActionState extends RestaurantCartState {
  final int cartItemId;

  RestaurantRemoveActionState({required this.cartItemId});
}

final class RestaurantRemoveFromCartSuccessState
    extends RestaurantRemoveActionState {
  final int id;

  RestaurantRemoveFromCartSuccessState({required this.id})
    : super(cartItemId: id);
}

final class RestaurantRemoveFromCartFailureState
    extends RestaurantRemoveActionState {
  final int id;
  final String errMsg;

  RestaurantRemoveFromCartFailureState(this.errMsg, {required this.id})
    : super(cartItemId: id);
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restaurant_cart_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/repo/cart/restaurant_cart_repo.dart';

part 'restaurant_cart_state.dart';

class RestaurantCartCubit extends Cubit<RestaurantCartState> {
  RestaurantCartCubit(this.cart) : super(RestaurantCartInitial());

  final RestaurantCartRepo cart;
  List<RestaurantCartModel> cartList = [];

  void onRetry() {
    emit(RestaurantCartOnRetryState());
  }

  Future<void> getMyCart({required String restaurantId}) async {
    emit(RestaurantGetCartLoadingState());
    final String? residentId = await getUserId();
    final result = await cart.getCartItems(
      residentId: residentId!,
      restaurantId: restaurantId,
    );
    result.fold(
      (failure) {
        if (failure is NoInternetFailure) {
          emit(RestaurantCartNetworkState());
        } else {
          emit(RestaurantCartFailureState());
        }
      },
      (cart) {
        cartList = cart;
        emit(RestaurantGetCartLoadedState(cart: cartList));
      },
    );
  }

  Future<void> removeItemFromCart(RestaurantCartModel item) async {
    final String? residentId = await getUserId();
    final result = await cart.removeFromCart(
      cartItemId: item.cartItemId,
      residentId: residentId!,
    );
    result.fold(
      (failure) {
        emit(
          RestaurantRemoveFromCartFailureState(failure, id: item.cartItemId),
        );
      },
      (success) {
        cartList.remove(item);
        emit(RestaurantRemoveFromCartSuccessState(id: item.cartItemId));
      },
    );
  }

  Future<void> updatItemQuantity(
    RestaurantCartModel item, {
    required bool isIncrement,
  }) async {
    double itemPrice = item.totalPrice / item.quantity;
    if (isIncrement) {
      item.quantity++;
      item.totalPrice = itemPrice * item.quantity;
    } else {
      if (item.quantity > 1) {
        item.quantity--;
        item.totalPrice = itemPrice * item.quantity;
      }
    }
    final String? residentId = await getUserId();
    final result = await cart.updateQuantity(
      cartItemId: item.cartItemId,
      residentId: residentId!,
      quantity: item.quantity,
    );
    result.fold(
      (failure) {
        if (isIncrement && item.quantity > 1) {
          item.quantity--;
          item.totalPrice = itemPrice * item.quantity;
        } else {
          item.quantity++;
          item.totalPrice = itemPrice * item.quantity;
        }
        emit(RestaurantCartUpateQuantityState(itemId: item.cartItemId));
      },
      (success) {
        emit(RestaurantCartUpateQuantityState(itemId: item.cartItemId));
      },
    );
  }
}

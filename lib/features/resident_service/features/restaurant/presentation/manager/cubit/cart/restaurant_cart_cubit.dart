import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/core/models/payment_model.dart';
import 'package:wasla/core/models/payment_result_mode.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restaurant_cart_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/repo/cart/restaurant_cart_repo.dart';

part 'restaurant_cart_state.dart';

class RestaurantCartCubit extends Cubit<RestaurantCartState> {
  RestaurantCartCubit(this.cart) : super(RestaurantCartInitial());

  final RestaurantCartRepo cart;
  List<RestaurantCartModel> cartList = [];
  PaymentMethod paymentMethod = PaymentMethod.cash;
  void onRetry() {
    emit(RestaurantCartOnRetryState());
  }

  void changePaymentMethod(PaymentMethod paymentMethod) {
    this.paymentMethod = paymentMethod;
    emit(RestaurantUpdatePaymentStauts());
  }

  Future<void> getMyCart({required String restaurantId}) async {
    cartList.clear();
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
    result.fold((failure) {}, (success) {
      cartList.remove(item);
      emit(RestaurantGetCartLoadedState(cart: cartList));
    });
  }

  Future<void> updatItemQuantity(
    RestaurantCartModel item, {
    required bool isIncrement,
  }) async {
    double itemPrice = item.totalPrice / item.quantity;
    if (isIncrement) {
      item.quantity++;
      log(item.quantity.toString());
      item.totalPrice = itemPrice * item.quantity;
    } else {
      if (item.quantity > 1) {
        item.quantity--;
        item.totalPrice = itemPrice * item.quantity;
      } else {
        return;
      }
    }
    emit(RestaurantCartUpadteQuantityState(itemId: item.cartItemId));
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
        emit(RestaurantCartUpadteQuantityState(itemId: item.cartItemId));
      },
      (success) {
        emit(RestaurantCartUpadteQuantityState(itemId: item.cartItemId));
      },
    );
  }

  Future<void> checkOut({
    required String address,
    required String notes,
    required String restaurantId,
  }) async {
    emit(RestaurantCartCheckoutLoadingState());
    final String? residentId = await getUserId();
    final result = await cart.restaurantCheckout(
      residentId: residentId!,
      address: address,
      notes: notes,
      paymentMethod: paymentMethod,
      restaurantId: restaurantId,
    );
    result.fold(
      (failure) {
        emit(RestaurantCartCheckoutFailureState(errMsg: failure));
      },
      (success) {
        if (success is PaymentCashModel) {
          emit(RestaurantCartCheckoutWithCashSuccessState());
        } else if (success is PaymentModel) {
          emit(RestaurantCartCheckoutSuccessState(paymentModel: success));
        }
      },
    );
  }

  double get calcTotalCost {
    double totalCost = 0;
    for (int i = 0; i < cartList.length; i++) {
      totalCost += cartList[i].totalPrice;
    }
    return totalCost;
  }
}

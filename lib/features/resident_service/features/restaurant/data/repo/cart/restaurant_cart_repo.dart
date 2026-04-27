import 'package:dartz/dartz.dart';
import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/models/payment_result_mode.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/restaurant_cart_model.dart';

abstract class RestaurantCartRepo {
  Future<Either<Failure, List<RestaurantCartModel>>> getCartItems({
    required String residentId,
    required String restaurantId,
  });
  Future<Either<String, Null>> updateQuantity({
    required String residentId,
    required int quantity,
    required int cartItemId,
  });
  Future<Either<String, Null>> removeFromCart({
    required String residentId,
    required int cartItemId,
  });
  Future<Either<String, PaymentResultModel>> restaurantCheckout({
    required String restaurantId,
    required String residentId,
    required String address,
    required String notes,
    required PaymentMethod paymentMethod,
  });
}

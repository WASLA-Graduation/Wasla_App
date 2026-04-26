import 'package:dartz/dartz.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/service/service_locator.dart';

abstract class PaymentService {
  static Future<Either<String, String>> createPayment({
    required String userId,
    required String serviceProviderId,
    required int serviceId,
    required int amount,
    required int serviceProviderType,
    required int bookingId,
    int paymentMethod = 1,
  }) async {
    try {
      final response = await sl<ApiConsumer>().post(
        ApiEndPoints.createPayment,

        body: {
          ApiKeys.userId: userId,
          ApiKeys.serviceProviderId: serviceProviderId,
          ApiKeys.serviceId: serviceId,
          ApiKeys.amount: amount,
          ApiKeys.serviceProviderType: serviceProviderType,
          ApiKeys.bookingId: bookingId,
          ApiKeys.paymentMethod: paymentMethod,
        },
      );
      return Right(response[ApiKeys.data]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  static Future<Either<String, bool>> checkPaymentStatus({
    required int entityId,
  }) async {
    try {
      final response = await sl<ApiConsumer>().post(
        ApiEndPoints.checkPaymentStatus,
        queryParameters: {ApiKeys.entityId: entityId, ApiKeys.entityType: 1},
      );
      return Right(response[ApiKeys.data][ApiKeys.isPaid]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }
}

import 'dart:developer';

import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/enums/service_provider_type.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/payment/data/models/resident_payment_model.dart';
import 'package:wasla/features/payment/data/models/service_provider_payment_model.dart';

class PaymentService {
  static Future<Either<String, String>> createPayment({
    required String userId,
    required String serviceProviderId,
    required int amount,
    required int serviceProviderType,
    required int bookingId,
    required int entityType,
    int paymentMethod = 1,
  }) async {
    try {
      final response = await sl<ApiConsumer>().post(
        ApiEndPoints.createPayment,

        body: {
          ApiKeys.userId: userId,
          ApiKeys.serviceProviderId: serviceProviderId,
          ApiKeys.amount: amount,
          ApiKeys.paymentMethod: paymentMethod,
          ApiKeys.entityId: bookingId,
          ApiKeys.entityType: entityType,
          ApiKeys.serviceType: serviceProviderType,
        },
      );
      return Right(response[ApiKeys.data]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  static Future<Either<String, bool>> checkPaymentStatus({
    required int entityId,
    required EntityType entityType,
  }) async {
    try {
      final response = await sl<ApiConsumer>().get(
        ApiEndPoints.checkPaymentStatus,
        queryParameters: {
          ApiKeys.entityId: entityId,
          ApiKeys.entityType: entityType.index,
        },
      );
      return Right(response[ApiKeys.data][ApiKeys.isPaid]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    } catch (e) {
      return Left(e.toString());
    }
  }

  Future<Either<Failure, List<ResidentPaymentModel>>> getResidentPayments({
    required String residentId,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await sl<ApiConsumer>().get(
        '${ApiEndPoints.getPaymentsForResident}$residentId',
      );

      List<ResidentPaymentModel> payments = [];
      for (var payment in response[ApiKeys.data]) {
        if (payment['entityType'] <= 1) {
          payments.add(ResidentPaymentModel.fromJson(payment));
        }
      }

      return Right(payments);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      log(e.toString());
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, List<ServiceProviderPaymentModel>>>
  getServiceProviderPayments({required String serviceProvider}) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }

      final response = await sl<ApiConsumer>().get(
        '${ApiEndPoints.getPaymentsForServiceProvider}$serviceProvider',
      );

      List<ServiceProviderPaymentModel> payments = [];
      for (var payment in response[ApiKeys.data]) {
        if (payment['entityType'] <= 1) {
          payments.add(ServiceProviderPaymentModel.fromJson(payment));
        }
      }
      return Right(payments);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

import 'package:dartz/dartz.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/api/api_consumer.dart';
import 'package:wasla/core/database/api/api_end_points.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/api/errors/api_exceptions.dart';
import 'package:wasla/core/error/failure.dart';
import 'package:wasla/core/service/service_locator.dart';
import 'package:wasla/features/notifications/data/models/notification_pagination_model.dart';
import 'package:wasla/features/notifications/data/repo/notification_repo.dart';

class NotificationRepoImpl implements NotificationRepo {
  final ApiConsumer api;

  NotificationRepoImpl({required this.api});

  @override
  Future<Either<String, Null>> deleteNotification({
    required int notificationId,
  }) async {
    try {
      await api.delete(
        ApiEndPoints.deleteNotification + notificationId.toString(),
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> markAsReadLastNotificatons({
    required String userId,
  }) async {
    try {
      await api.post(
        '${ApiEndPoints.markAllReadLastSeenNotifications}$userId/MarkAllAsSeen',
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, Null>> markAsReadNotification({
    required int notificationId,
  }) async {
    try {
      await api.post(
        '${ApiEndPoints.markAAsSeenNotification}$notificationId/MarkAsSeen',
      );
      return const Right(null);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<String, int>> getTotalNumbersOfUnReadLastSeen({
    required String userId,
  }) async {
    try {
      final response = await api.get(
        '${ApiEndPoints.getTotalNumberOfLastSeenNotifications}$userId/AfterLastSeen',
      );

      return Right(response[ApiKeys.data]);
    } on ServerException catch (e) {
      return Left(e.errorModel.errorMessage);
    }
  }

  @override
  Future<Either<Failure, NotificationPaginationModel>> getAllNotifications({
    required String userId,
    required int pageNumber,
    required int pageSize,
  }) async {
    try {
      if (!await sl<NetworkInfo>().isConnected) {
        return Left(NoInternetFailure());
      }
      final response = await api.get(
        '${ApiEndPoints.getAllNotifications}$userId',
        queryParameters: {
          ApiKeys.pageNumber: pageNumber,
          ApiKeys.pageSize: pageSize,
        },
      );
      return Right(
        NotificationPaginationModel.fromJson(response[ApiKeys.data]),
      );
    } on ServerException catch (e) {
      return Left(ServerFailure(e.errorModel.errorMessage));
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}

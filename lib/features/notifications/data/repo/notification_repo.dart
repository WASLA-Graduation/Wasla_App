import 'package:dartz/dartz.dart';
import 'package:wasla/features/notifications/data/models/notification_pagination_model.dart';

abstract class NotificationRepo {
  Future<Either<String, Null>> deleteNotification({
    required int notificationId,
  });
  Future<Either<String, Null>> markAsReadLastNotificatons({
    required String userId,
  });

  Future<Either<String, Null>> markAsReadNotification({
    required int notificationId,
  });
  Future<Either<String, int>> getTotalNumbersOfUnReadLastSeen({
    required String userId,
  });
  Future<Either<String, NotificationPaginationModel>> getAllNotifications({
    required String userId,
    required int pageNumber,
    required int pageSize,
  });
}

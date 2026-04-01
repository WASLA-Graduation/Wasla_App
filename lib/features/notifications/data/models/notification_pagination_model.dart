import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/features/notifications/data/models/notification_model.dart';

class NotificationPaginationModel {
  final int pageNumber;
  final int pageSize;
  final int totalCount;
  final List<NotificationModel> notifications;

  NotificationPaginationModel({
    required this.pageNumber,
    required this.pageSize,
    required this.totalCount,
    required this.notifications,
  });

  factory NotificationPaginationModel.fromJson(Map<String, dynamic> json) {
    return NotificationPaginationModel(
      pageNumber: json[ApiKeys.pageNumber] ?? 0,
      pageSize: json[ApiKeys.pageSize] ?? 0,
      totalCount: json[ApiKeys.totalCount] ?? 0,
      notifications: (json[ApiKeys.data] as List? ?? [])
          .map((e) => NotificationModel.fromJson(e))
          .toList(),
    );
  }
}

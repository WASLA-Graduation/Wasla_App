import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';

class NotificationModel {
  final int notificatonId;
  final String title;
  final String body;
  final String serviceProviderId;
  bool isRead;
  final DateTime createdAt;
  DateTime? lastSeenAt;
  final int routeIndex;
  String? image;

  NotificationModel({
    required this.routeIndex,
    required this.notificatonId,
    required this.title,
    required this.body,
    this.image,
    required this.serviceProviderId,
    required this.isRead,
    required this.createdAt,
    this.lastSeenAt,
  });

  factory NotificationModel.fromJson(Map<String, dynamic> json) {
    return NotificationModel(
      notificatonId: json[ApiKeys.id] ?? 0,
      title: json[ApiKeys.title] ?? '',
      body: json[ApiKeys.body] ?? '',
      image: json[ApiKeys.imageUrl]??'',
      serviceProviderId: json[ApiKeys.referenceId],
      isRead: json[ApiKeys.isSeen],
      createdAt: DateTime.parse(
        json[ApiKeys.createdAt] ?? DateTime.now().toIso8601String(),
      ),
      lastSeenAt: json[ApiKeys.lastSeenAt] != null
          ? DateTime.parse(json[ApiKeys.lastSeenAt])
          : null,
      routeIndex: json[ApiKeys.type] ?? 0,
    );
  }

  static List<NotificationModel> sortNotificationsDescending(
    List<NotificationModel> notifications,
  ) {
    final List<NotificationModel> sortedNotifications = List.from(
      notifications,
    );
    sortedNotifications.sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return sortedNotifications;
  }

  static Map<String, List<NotificationModel>> sparateNotificationsToSections({
    required List<NotificationModel> notifications,
  }) {
    final Map<String, List<NotificationModel>> sections = {};

    for (var notification in notifications) {
      final sectionTitle = getSectionTitle(notification.createdAt);

      sections.putIfAbsent(sectionTitle, () => []);
      sections[sectionTitle]!.add(notification);
    }

    return sections;
  }
}

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/get_user_id.dart';
import 'package:wasla/features/notifications/data/models/notification_model.dart';
import 'package:wasla/features/notifications/data/repo/notification_repo.dart';
part 'notification_state.dart';

class NotificationCubit extends Cubit<NotificationState> {
  NotificationCubit({required this.notificationRepo})
    : super(NotificationInitial());
  Map<String, List<NotificationModel>> notificationsSections = {};
  final NotificationRepo notificationRepo;
  int selectedNotificationId = -1;
  int pageNumber = 1;
  int pageSize = 8;
  int totoalLastSeenNotifications = 0;
  bool theEndPaginations = false;

  Future<void> fetchNotifications({required bool fromPagination}) async {
    if (theEndPaginations ||
        (fromPagination && state is GetNotificationFromPaginationLoading)) {
      return;
    }
    if (fromPagination) {
      emit(GetNotificationFromPaginationLoading());
    } else {
      emit(GetNotificationLoading());
    }

    final String userId = await getUserId() ?? '';

    final result = await notificationRepo.getAllNotifications(
      userId: userId,
      pageNumber: pageNumber,
      pageSize: pageSize,
    );

    result.fold((error) => emit(GetNotificationFailure(errMsg: error)), (
      success,
    ) {
      if (success.notifications.isEmpty) {
        theEndPaginations = true;
      } else {
        pageNumber++;
        List<NotificationModel> sortedNotifications =
            NotificationModel.sortNotificationsDescending(
              success.notifications,
            );
        Map<String, List<NotificationModel>> newSections =
            NotificationModel.sparateNotificationsToSections(
              notifications: sortedNotifications,
            );
        mergetwomaps(notificationsSections, newSections);
      }

      emit(GEtNotificationLoaded(sections: notificationsSections));
    });
  }

  //Done
  Future<void> deleteNotification(int notificationId) async {
    notificationsSections.forEach((section, notifications) {
      notifications.removeWhere(
        (notification) => notification.notificatonId == notificationId,
      );
    });

    final result = await notificationRepo.deleteNotification(
      notificationId: notificationId,
    );
    result.fold(
      (error) => throw Exception(error),
      (success) => emit(DeleteNotificationSuccess()),
    );
  }

  //Done
  Future<void> readNotification(NotificationModel notification) async {
    NotificationModel? editedNotification;

    selectedNotificationId = notification.notificatonId;

    for (var section in notificationsSections.values) {
      for (var item in section) {
        if (item.notificatonId == notification.notificatonId) {
          editedNotification = item;
          editedNotification.isRead = true;
          break;
        }
      }
    }

    final result = await notificationRepo.markAsReadNotification(
      notificationId: notification.notificatonId,
    );
    result.fold((error) {
      if (editedNotification != null) {
        editedNotification.isRead = false;
      }

      emit(ReadNotificationFailure());
    }, (success) => emit(ReadNotificationSuccess()));
  }

  //Done
  Future<void> markAsReadLastSeenNotifications() async {
    totoalLastSeenNotifications = 0;
    emit(GetLastSeenCountNotificationaSuccess());
    final String? userId = await getUserId();
    await notificationRepo.markAsReadLastNotificatons(userId: userId!);
  }

  //Done
  Future<void> getLastSeenNotificationsCount() async {
    final String? userId = await getUserId();
    final result = await notificationRepo.getTotalNumbersOfUnReadLastSeen(
      userId: userId!,
    );
    result.fold((error) => null, (success) {
      totoalLastSeenNotifications = success;
      emit(GetLastSeenCountNotificationaSuccess());
    });
  }

  void reset() {
    notificationsSections = {};
    selectedNotificationId = -1;
    pageNumber = 1;
    pageSize = 8;
    theEndPaginations = false;
  }

  void mergetwomaps(
    Map<String, List<NotificationModel>> map1,
    Map<String, List<NotificationModel>> map2,
  ) {
    map2.forEach((key, value) {
      if (map1.containsKey(key)) {
        final existing = map1[key]!;

        final merged = [
          ...existing,
          ...value.where(
            (newItem) => !existing.any(
              (oldItem) => oldItem.notificatonId == newItem.notificatonId,
            ),
          ),
        ];

        map1[key] = merged;
      } else {
        map1[key] = value;
      }
    });
  }
}

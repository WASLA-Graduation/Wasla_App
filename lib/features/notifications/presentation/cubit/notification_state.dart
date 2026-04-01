part of 'notification_cubit.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

final class GetNotificationLoading extends NotificationState {}
final class GetNotificationFromPaginationLoading extends NotificationState {}

final class GEtNotificationLoaded extends NotificationState {
  final Map<String, List<NotificationModel>> sections;
  GEtNotificationLoaded({required this.sections});
}

final class GetNotificationFailure extends NotificationState {
  final String errMsg;
  GetNotificationFailure({required this.errMsg});
}

final class DeleteNotificationSuccess extends NotificationState {}

final class ReadNotificationSuccess extends NotificationState {}
final class GetLastSeenCountNotificationaSuccess extends NotificationState {}
final class ReadNotificationFailure extends NotificationState {}

part of 'notification_cubit.dart';

sealed class NotificationState {}

final class NotificationInitial extends NotificationState {}

//basic 3 states
final class NotificationFailureState extends NotificationState {}
final class NotificationNetworkState extends NotificationState {}
final class NotificationOnRetryState extends NotificationState {}


final class GetNotificationLoading extends NotificationState {}
final class GetNotificationFromPaginationLoading extends NotificationState {}

final class GEtNotificationLoaded extends NotificationState {
  final Map<String, List<NotificationModel>> sections;
  GEtNotificationLoaded({required this.sections});
}



final class DeleteNotificationSuccess extends NotificationState {}

final class ReadNotificationSuccess extends NotificationState {}
final class GetLastSeenCountNotificationaSuccess extends NotificationState {}
final class ReadNotificationFailure extends NotificationState {}

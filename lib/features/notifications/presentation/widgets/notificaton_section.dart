import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/notificatons_routes.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/notifications/data/models/notification_model.dart';
import 'package:wasla/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:wasla/features/notifications/presentation/widgets/notification_section_item.dart';

class NotificationListSection extends StatelessWidget {
  const NotificationListSection({
    super.key,
    required this.sectionTitle,
    required this.items,
  });

  final String sectionTitle;
  final List<NotificationModel> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Text(
            sectionTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),

        ...items.map(
          (notification) => Slidable(
            useTextDirection: true,

            closeOnScroll: true,
            key: ValueKey(notification.notificatonId),
            endActionPane: ActionPane(
              extentRatio: 0.20,

              motion: const ScrollMotion(),
              children: [
                CustomSlidableAction(
                  borderRadius: BorderRadius.circular(12),
                  onPressed: (ctx) async {
                    await context
                        .read<NotificationCubit>()
                        .deleteNotification(notification.notificatonId)
                        .then(
                          (value) => toastAlert(
                            color: AppColors.primaryColor,
                            msg: "noNotificationsDeleted".tr(context),
                          ),
                        )
                        .catchError((error) {
                          toastAlert(
                            color: AppColors.red,
                            msg: "notificationNotDeleted".tr(context),
                          );
                        });
                  },
                  backgroundColor: AppColors.primaryColor,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.delete, size: 20, color: Colors.white),
                      const SizedBox(height: 4),
                      Text(
                        'delete'.tr(context),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            child: InkWell(
              onTap: () async {
                context.read<NotificationCubit>().readNotification(
                  notification,
                );
                NotificationRoute route = NotificationRoute.fromInt(
                  notification.routeIndex,
                );

                navigateToRightRoute(
                  route: route,
                  referenceId: notification.serviceProviderId,
                );
              },

              child: BlocBuilder<NotificationCubit, NotificationState>(
                buildWhen: (previous, current) =>
                    context.read<NotificationCubit>().selectedNotificationId ==
                    notification.notificatonId,
                builder: (context, state) {
                  context.read<NotificationCubit>().selectedNotificationId = -1;
                  return NotificationSectionItem(notification: notification);
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}

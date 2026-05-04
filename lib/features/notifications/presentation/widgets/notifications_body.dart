import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/notifications/data/models/notification_model.dart';
import 'package:wasla/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:wasla/features/notifications/presentation/widgets/notificatons_list.dart';

class NotificationBody extends StatefulWidget {
const  NotificationBody({super.key});

  @override
  State<NotificationBody> createState() => _NotificationBodyState();
}

class _NotificationBodyState extends State<NotificationBody> {
  Map<String, List<NotificationModel>> notificationsSections = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) =>
          current is DeleteNotificationSuccess ||
          current is GetNotificationLoading ||
          current is GEtNotificationLoaded,
      builder: (context, state) {
        if (state is GetNotificationLoading || state is NotificationInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          if (state is GEtNotificationLoaded) {
            notificationsSections = state.sections;
          }
          if (notificationsSections.isEmpty) {
            return EmptyStateWidget(title: "noNotifications".tr(context));
          }

          return NotificationList(sections: notificationsSections);
        }
      },
    );
  }
}

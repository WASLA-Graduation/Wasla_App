import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
import 'package:wasla/features/notifications/data/models/notification_model.dart';
import 'package:wasla/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:wasla/features/notifications/presentation/widgets/notificatons_list.dart';

// ignore: must_be_immutable
class NotificationBody extends StatelessWidget {
  NotificationBody({super.key});

  Map<String, List<NotificationModel>> notificationsSections = {};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotificationCubit, NotificationState>(
      buildWhen: (previous, current) =>
          current is DeleteNotificationSuccess ||
          current is GetNotificationFailure ||
          current is GetNotificationLoading ||
          current is GEtNotificationLoaded,
      builder: (context, state) {
        if (state is GetNotificationFailure) {
          return CustomErrGetData();
        } else if (state is GetNotificationLoading) {
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
            return Center(
              child: Text(
                "noNotifications".tr(context),
                style: TextStyle(fontSize: 18),
              ),
            );
          }

          return NotificationList(sections: notificationsSections);
        }
      },
    );
  }
}

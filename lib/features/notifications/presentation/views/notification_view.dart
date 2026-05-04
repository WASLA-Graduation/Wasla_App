import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:wasla/features/notifications/presentation/widgets/notifications_body.dart';

class NotificationView extends StatefulWidget {
  const NotificationView({super.key});

  @override
  State<NotificationView> createState() => _NotificationViewState();
}

class _NotificationViewState extends State<NotificationView> {
  @override
  void initState() {
    super.initState();
    fetchNotifications();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('notifications'.tr(context))),

      body: BlocStatusHandler<NotificationCubit, NotificationState>(
        body: const NotificationBody(),
        onRetry: () {
          context.read<NotificationCubit>().onRetry();
          fetchNotifications();
        },
        isNetwork: (state) => state is NotificationNetworkState,
        isError: (state) => state is NotificationFailureState,
        buildWhen: (previous, current) =>
            current is NotificationNetworkState ||
            current is NotificationFailureState ||
            current is NotificationOnRetryState,
      ),
    );
  }

  void fetchNotifications() {
    context.read<NotificationCubit>().reset();
    context.read<NotificationCubit>().fetchNotifications(fromPagination: false);
  }
}

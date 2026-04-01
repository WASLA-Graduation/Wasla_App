import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/pagination_widget.dart';
import 'package:wasla/features/notifications/data/models/notification_model.dart';
import 'package:wasla/features/notifications/presentation/cubit/notification_cubit.dart';
import 'package:wasla/features/notifications/presentation/widgets/notificaton_section.dart';

class NotificationList extends StatelessWidget {
  const NotificationList({super.key, required this.sections});

  final Map<String, List<NotificationModel>> sections;

  @override
  Widget build(BuildContext context) {
    return PaginationListener(
      onLoadMore: () async {
        context.read<NotificationCubit>().fetchNotifications(
          fromPagination: true,
        );
      },
      child: Column(
        children: [
          Expanded(
            child: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
              children: sections.entries.map((entry) {
                final sectionTitle = entry.key;
                final items = entry.value;

                return NotificationListSection(
                  sectionTitle: sectionTitle,
                  items: items,
                );
              }).toList(),
            ),
          ),

          BlocBuilder<NotificationCubit, NotificationState>(
            builder: (context, state) {
              return state is GetNotificationFromPaginationLoading
                  ? Padding(
                      padding: EdgeInsets.only(bottom: 20),
                      child: CircularProgressIndicator(
                        color: AppColors.primaryColor,
                      ),
                    )
                  : const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }
}

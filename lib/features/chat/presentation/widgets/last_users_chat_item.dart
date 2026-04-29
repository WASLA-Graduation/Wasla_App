import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/features/chat/data/models/users_chat_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/get_message_sub_title.dart';

class LastUsersChatItem extends StatelessWidget {
  const LastUsersChatItem({super.key, required this.userChat});
  final UsersChatMsgModel userChat;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    return Slidable(
      useTextDirection: true,
      closeOnScroll: true,

      key: ValueKey(userChat.chatId),
      endActionPane: ActionPane(
        extentRatio: 0.20,

        motion: const ScrollMotion(),
        children: [
          CustomSlidableAction(
            borderRadius: BorderRadius.circular(12),
            onPressed: (ctx) async {
              await context.read<ChatCubit>().deleteChat(user: userChat);
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
                  style: const TextStyle(fontSize: 16, color: Colors.white),
                ),
              ],
            ),
          ),
        ],
      ),
      child: BlocBuilder<ChatCubit, ChatState>(
        buildWhen: (previous, current) =>
            (current is ChatUpdateMsg && current.msgId == userChat.messageId) ||
            current is ChatReadMsgs ||
            current is ChatDeleteMsg &&
                cubit.selectedMsgId == userChat.messageId,
        builder: (context, state) {
          return ListTile(
            contentPadding: EdgeInsets.zero,
            leading: CircleNeworkImage(
              size: 53,
              imageUrl: userChat.profileReceiver,
              isLoading: false,
            ),

            title: Text(
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              userChat.name,
              style: Theme.of(context).textTheme.bodySmall,
            ),
            subtitle: GetChatSubTitle(userChat: userChat),
            trailing: Padding(
              padding: const EdgeInsets.only(right: 7),
              child: Column(
                children: [
                  Visibility(
                    visible: userChat.unreadMessageCount > 0,
                    child: Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
                        ),
                      ),
                      child: Center(
                        child: Text(
                          userChat.unreadMessageCount.toString(),
                          style: Theme.of(context).textTheme.labelSmall!
                              .copyWith(
                                color: AppColors.whiteColor,
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    formatDateToCustomString(userChat.sentAt),
                    style: Theme.of(context).textTheme.labelSmall,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

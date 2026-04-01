import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/msg_type_enum.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/chat/data/models/users_chat_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';

class GetChatSubTitle extends StatelessWidget {
  const GetChatSubTitle({super.key, required this.userChat});

  final UsersChatMsgModel userChat;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();

    final bool isMe = cubit.currentUser == userChat.senderId;
    final MessageType messageType = MessageType.values[userChat.type - 1];
    if (!isMe) {
      switch (messageType) {
        case MessageType.text:
          return Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            userChat.messageText,
            style: userChat.unreadMessageCount > 0
                ? Theme.of(context).textTheme.displaySmall!.copyWith(
                    fontWeight: FontWeight.bold,
                  )
                : Theme.of(context).textTheme.labelSmall,
          );
        case MessageType.image:
          return Row(
            spacing: 3,
            children: [
              Icon(Icons.image, color: Colors.grey, size: 22),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '${userChat.files.length} ${'images'.tr(context)}',
                style: userChat.unreadMessageCount > 0
                    ? Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    : Theme.of(context).textTheme.labelSmall,
              ),
            ],
          );
        case MessageType.audio:
          return Row(
            spacing: 3,
            children: [
              Icon(Icons.mic, color: Colors.grey, size: 22),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                'voiceMessage'.tr(context),
                style: userChat.unreadMessageCount > 0
                    ? Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    : Theme.of(context).textTheme.labelSmall,
              ),
            ],
          );
        case MessageType.mixed:
          return Row(
            spacing: 3,
            children: [
              Icon(Icons.image, color: Colors.grey, size: 22),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                userChat.messageText,
                style: userChat.unreadMessageCount > 0
                    ? Theme.of(context).textTheme.displaySmall!.copyWith(
                        fontWeight: FontWeight.bold,
                      )
                    : Theme.of(context).textTheme.labelSmall,
              ),
            ],
          );
      }
    } else {
      switch (messageType) {
        case MessageType.text:
          return Row(
            spacing: 3,
            children: [
              Icon(
                Icons.done_all,
                color: userChat.readAt != null
                    ? AppColors.seenColor
                    : Colors.grey,
                size: 22,
              ),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                userChat.messageText,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          );
        case MessageType.image:
          return Row(
            spacing: 3,
            children: [
              Icon(
                Icons.done_all,
                color: userChat.readAt != null ? AppColors.seenColor : Colors.grey,
                size: 22,
              ),
              Icon(Icons.image, color: Colors.grey, size: 22),
            ],
          );
        case MessageType.audio:
          return Row(
            spacing: 3,
            children: [
              Icon(
                Icons.done_all,
                color: userChat.readAt != null ? AppColors.seenColor : Colors.grey,
                size: 22,
              ),
              Icon(Icons.mic, color: Colors.grey, size: 22),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                'voiceMessage'.tr(context),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          );
        case MessageType.mixed:
          return Row(
            spacing: 3,
            children: [
              Icon(
                Icons.done_all,
                color: userChat.readAt != null ? AppColors.seenColor : Colors.grey,
                size: 22,
              ),
              Icon(Icons.image, color: Colors.grey, size: 22),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                userChat.messageText,
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ],
          );
      }
    }
  }
}

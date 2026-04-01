import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/msg_type_enum.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/chat/data/models/chats_msg_model.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_item_image.dart';

class MessageItemData extends StatelessWidget {
  const MessageItemData({super.key, required this.message, required this.isMe});

  final MessageModel message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    final MessageType messageType = MessageType.values[message.type - 1];
    switch (messageType) {
      case MessageType.text:
        return Text(
          message.messageText ?? '',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: isMe ? AppColors.whiteColor : AppColors.blackColor,
          ),
        );
      case MessageType.image:
        if (message.files.isEmpty) {
          return const SizedBox();
        }
        return ChatItemImage(
          images: message.files,
          isMe: isMe,
          sentAt: message.sentAt,
        );
      case MessageType.audio:
        return Text(
          'voiceMessage'.tr(context),
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: isMe ? AppColors.whiteColor : AppColors.blackColor,
          ),
        );
      case MessageType.mixed:
        return Text(
          'Mixed Message',
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
            color: isMe ? AppColors.whiteColor : AppColors.blackColor,
          ),
        );
    }
  }
}

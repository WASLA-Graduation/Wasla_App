import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/msg_type_enum.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/chat/data/models/chats_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/message_item_content.dart';
import 'package:wasla/features/chat/presentation/widgets/msg_on_long_press.dart';

class ChatMsgItem extends StatelessWidget {
  const ChatMsgItem({super.key, required this.message});
  final MessageModel message;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    final bool isMe = cubit.currentUser == message.senderId;
    final MessageType messageType = MessageType.values[message.type - 1];

    return GestureDetector(
      onLongPress: () {
        if (message.senderId == cubit.currentUser) {
          showModalBottomSheet(
            context: context,
            builder: (context) => MsgOnLongPress(message: message),
          );
        }
      },
      child: Align(
        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          padding: messageType == MessageType.audio
              ? EdgeInsets.zero
              : EdgeInsets.symmetric(vertical: 12, horizontal: 17),
          width: messageType == MessageType.audio
              ? SizeConfig.blockWidth * 82
              : SizeConfig.blockWidth * 71,

          decoration: messageType == MessageType.audio
              ? null
              : BoxDecoration(
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                    topLeft: isMe ? Radius.circular(10) : Radius.zero,
                    topRight: isMe ? Radius.zero : Radius.circular(10),
                  ),
                  color: isMe ? AppColors.primaryColor : Colors.grey.shade300,
                ),
          child: MessageItemContent(message: message, isMe: isMe),
        ),
      ),
    );
  }
}

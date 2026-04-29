import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/msg_type_enum.dart';
import 'package:wasla/features/chat/data/models/chats_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_item_audio_player_widget.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_msg_image_widget.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_msg_text_widget.dart';

class MessageItemContent extends StatelessWidget {
  const MessageItemContent({
    super.key,
    required this.message,
    required this.isMe,
  });

  final MessageModel message;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) =>
          current is ChatUpdateMsg && current.msgId == message.messageId,
      builder: (context, state) {
        return buildMessageItem(context: context);
      },
    );
  }

  Widget buildMessageItem({required BuildContext context}) {
    final MessageType messageType = MessageType.values[message.type - 1];
    switch (messageType) {
      case MessageType.text:
        return ChatMsgTextWiget(message: message);
      case MessageType.image:
        return ChatMsgImageWidget(message: message, withText: false);
      case MessageType.audio:
        // return ChatItemPlayRecordWidget(message: message);
        return ChatItemAudioPlayerWidget(url: message.audio ?? '', isMe: isMe);
      case MessageType.mixed:
        return ChatMsgImageWidget(message: message, withText: true);
    }
  }
}

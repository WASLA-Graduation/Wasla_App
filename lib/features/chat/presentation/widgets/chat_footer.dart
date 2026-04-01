import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/service/Audio/audio_service.dart';
import 'package:wasla/core/service/Audio/record_service.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_record_item.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_send_mirco_widget.dart';
import 'package:wasla/features/chat/presentation/widgets/chat_text_field.dart';
import 'package:wasla/features/chat/presentation/widgets/choose_images_with_text.dart';

class ChatFooter extends StatefulWidget {
  const ChatFooter({super.key});

  @override
  State<ChatFooter> createState() => _ChatFooterState();
}

class _ChatFooterState extends State<ChatFooter> {
  @override
  void deactivate() {
    context.read<RecordService>().dispose();
    context.read<AudioService>().dispose();

    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    return Row(
      spacing: 10,
      children: [
        BlocBuilder<ChatCubit, ChatState>(
          buildWhen: (previous, current) =>
              current is ChatPickImages || current is ChatRecorded,
          builder: (context, state) {
            return Expanded(child: _buildChatInput(cubit));
          },
        ),
        BlocBuilder<ChatCubit, ChatState>(
          buildWhen: (previous, current) =>
              current is ChatWhenUserTyping || current is ChatPickImages,
          builder: (context, state) {
            return ChatSendOrMicrophoneWidet(
              type: messageType(context),
              isSend: context.read<ChatCubit>().isSend,
            );
          },
        ),

        BlocBuilder<ChatCubit, ChatState>(
          buildWhen: (previous, current) => current is ChatRecordChangePosition,
          builder: (context, state) {
            return SizedBox(width: context.read<ChatCubit>().targetOffsetDx);
          },
        ),
      ],
    );
  }

  int messageType(BuildContext context) {
    final cubit = context.read<ChatCubit>();
    if (cubit.images.isNotEmpty && cubit.messageController.text.isNotEmpty) {
      return 3;
    } else if (cubit.images.isNotEmpty &&
        cubit.messageController.text.isEmpty) {
      return 1;
    } else {
      return 0;
    }
  }

  Widget _buildChatInput(ChatCubit cubit) {
    if (cubit.images.isNotEmpty) {
      return ChatChooseImagesWithText(files: cubit.images);
    } else if (cubit.isRecording) {
      return ChatRecordItem();
    } else {
      return CustomChatTextField(controller: cubit.messageController);
    }
  }
}

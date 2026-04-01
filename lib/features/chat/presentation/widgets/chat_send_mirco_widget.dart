import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/service/Audio/audio_service.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';
import 'package:wasla/features/chat/presentation/widgets/record_button_widget.dart';

class ChatSendOrMicrophoneWidet extends StatelessWidget {
  const ChatSendOrMicrophoneWidet({
    super.key,
    required this.isSend,
    required this.type,
  });

  final bool isSend;
  final int type;

  @override
  Widget build(BuildContext context) {
    return isSend ? SendMsgWidget(type: type) : const RecordButtonWidget();
  }
}

class SendMsgWidget extends StatelessWidget {
  const SendMsgWidget({super.key, required this.type});
  final int type;
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 55,
      height: 55,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
        ),
        shape: BoxShape.circle,
      ),
      child: IconButton(
        onPressed: () {
          final audioService = context.read<AudioService>();
          final cubit = context.read<ChatCubit>();
          FocusScope.of(context).unfocus();
          cubit.sendMsg(type: type);
          audioService
              .loadAsset(assetPath: 'assets/audio/send.mp3')
              .then((_) => audioService.play());
        },
        icon: Icon(Icons.send, color: AppColors.whiteColor),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wasla/features/chat/presentation/widgets/audio_recorder_wave_widget.dart';
import 'package:wasla/features/chat/presentation/widgets/recorder_timer_widget.dart';

class ChatRecordItem extends StatefulWidget {
  const ChatRecordItem({super.key});

  @override
  State<ChatRecordItem> createState() => _ChatRecordItemState();
}

class _ChatRecordItemState extends State<ChatRecordItem> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        RecoderTimerWidget(),
        const SizedBox(width: 10),
        Expanded(child: AudioWaveWidget()),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:voice_note_kit/player/audio_player_widget.dart';
import 'package:voice_note_kit/player/player_enums/player_enums.dart';
import 'package:wasla/core/utils/app_colors.dart';

class ChatItemAudioPlayerWidget extends StatelessWidget {
  const ChatItemAudioPlayerWidget({
    super.key,
    required this.url,
    required this.isMe,
  });

  final String url;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    return AudioPlayerWidget(
      autoPlay: false,
      autoLoad: true,
      audioPath: url,
      audioType: AudioType.url,
      playerStyle: PlayerStyle.style5,
      textDirection: TextDirection.rtl,
      size: 40,
      progressBarHeight: 5,
      backgroundColor: isMe ? AppColors.primaryColor : Colors.grey.shade300,
      progressBarColor: isMe ? Colors.white : Colors.black,
      progressBarBackgroundColor: isMe ? Colors.white : Colors.black,
      iconColor: isMe ? Colors.white : Colors.black,
      shapeType: PlayIconShapeType.circular,
      showProgressBar: true,
      width: 300,

      audioSpeeds: const [0.5, 1.0, 1.5, 2.0],
      onSeek: (value) {},
      onError: (message) {},
      onPause: () {},
      onPlay: (isPlaying) {},
      onSpeedChange: (value) {},
    );
  }
}

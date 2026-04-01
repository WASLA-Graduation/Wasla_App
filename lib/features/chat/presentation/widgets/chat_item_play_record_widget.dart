import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:wasla/core/functions/format_date_from_string.dart';
import 'package:wasla/core/service/Audio/chat_audio_service.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/chat/data/models/chats_msg_model.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';

class ChatItemPlayRecordWidget extends StatefulWidget {
  const ChatItemPlayRecordWidget({super.key, required this.message});
  final MessageModel message;

  @override
  State<ChatItemPlayRecordWidget> createState() =>
      _ChatItemPlayRecordWidgetState();
}

class _ChatItemPlayRecordWidgetState extends State<ChatItemPlayRecordWidget> {
  final ChatAudioService audioService = ChatAudioService();
  Duration? duration = Duration.zero;
  Duration position = Duration.zero;
  StreamSubscription<Duration?>? subscriptionDuration;
  StreamSubscription<Duration>? subscriptionPosition;
  StreamSubscription<PlayerState>? subscriptionPlayState;

  @override
  void initState() {
    super.initState();

    subscriptionDuration = audioService.durationStream.listen((event) {
      setState(() {
        duration = event;
      });
    });

    subscriptionPosition = audioService.positionStream.listen((event) {
      setState(() {
        position = event;
      });
    });

    subscriptionPlayState = audioService.playerStateStream.listen((state) {
      if (state.processingState == ProcessingState.completed) {
        setState(() {});
        audioService.stop();
        position = Duration.zero;
      }
    });
  }

  @override
  void dispose() {
    subscriptionDuration?.cancel();
    subscriptionPosition?.cancel();
    subscriptionPlayState?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isMe =
        widget.message.senderId == context.read<ChatCubit>().currentUser;

    final bool isCurrent =
        audioService.currentPlayingMessageId ==
        widget.message.messageId.toString();

    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: SliderTheme(
                data: SliderTheme.of(context).copyWith(
                  trackHeight: 4,
                  thumbShape: const RoundSliderThumbShape(
                    enabledThumbRadius: 7,
                  ),
                  overlayShape: const RoundSliderOverlayShape(
                    overlayRadius: 14,
                  ),
                  activeTrackColor: AppColors.primaryColor,
                  inactiveTrackColor: AppColors.gray,
                  thumbColor: AppColors.primaryColor,
                ),
                child: Slider(
                  min: 0,
                  max: duration?.inMilliseconds.toDouble() ?? 0,
                  value: isCurrent ? position.inMilliseconds.toDouble() : 0,
                  onChanged: (value) async {
                    if (isCurrent) {
                      await audioService.seekTo(
                        position: Duration(milliseconds: value.toInt()),
                      );
                    }
                  },
                ),
              ),
            ),
            const SizedBox(width: 10),
            IconButton(
              onPressed: () {
                audioService.playRecord(
                  url: widget.message.audio ?? '',
                  messageId: widget.message.messageId.toString(),
                );
              },
              icon: Icon(
                isCurrent && audioService.isPlaying
                    ? Icons.pause
                    : Icons.play_arrow,
                color: AppColors.primaryColor,
                size: 25,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Expanded(
              child: Text(
                getTimeWithFormat(
                  duration: isCurrent ? position : duration ?? Duration.zero,
                ),
              ),
            ),
            Text(
              formatDateToCustomString(widget.message.sentAt),
              style: Theme.of(context).textTheme.labelSmall!.copyWith(
                color: isMe ? AppColors.whiteColor : AppColors.blackColor,
              ),
            ),
            const SizedBox(width: 5),
            Visibility(
              visible: isMe,
              child: Icon(
                Icons.done_all_sharp,
                color: widget.message.readAt != null
                    ? AppColors.seenColor
                    : AppColors.whiteColor,
                size: 20,
              ),
            ),
          ],
        ),
      ],
    );
  }

  String getTimeWithFormat({required Duration duration}) {
    final int min = duration.inMinutes;
    final int sec = duration.inSeconds % 60;
    return '${min.toString().padLeft(2, '0')}:${sec.toString().padLeft(2, '0')}';
  }
}

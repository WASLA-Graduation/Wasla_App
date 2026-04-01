import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/service/Audio/audio_service.dart';
import 'package:wasla/core/service/Audio/record_service.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/chat/presentation/manager/cubit/chat_cubit.dart';

class RecordButtonWidget extends StatefulWidget {
  const RecordButtonWidget({super.key});

  @override
  State<RecordButtonWidget> createState() => _RecordButtonWidgetState();
}

class _RecordButtonWidgetState extends State<RecordButtonWidget> {
  late final RecordService recordService;
  late final ChatCubit cubit;

  late final AudioService audioService;
  double targetOffsetDx = 0.0;
  bool isRecording = false;
  bool isCancelled = false;
  final double cancelThreshold = -100;
  double iconSacle = 1;

  @override
  void initState() {
    super.initState();
    recordService = context.read<RecordService>();
    audioService = context.read<AudioService>();
    cubit = context.read<ChatCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onLongPressStart: (_) async {
        cubit.changeRecordingState(isRecording: true);
        isRecording = true;
        isCancelled = false;
        targetOffsetDx = 0.0;
        iconSacle = 1.25;
        setState(() {});
        audioService
            .loadAsset(assetPath: 'assets/audio/send.mp3')
            .then((_) => audioService.play())
            .then((value) async => await recordService.start());
      },

      onLongPressMoveUpdate: (details) {
        if (isCancelled) return;
        setState(() {
          targetOffsetDx = details.offsetFromOrigin.dx;
          cubit.updateTargetOffest(dx: targetOffsetDx);
          if (targetOffsetDx < cancelThreshold && !isCancelled) {
            audioService
                .loadAsset(assetPath: 'assets/audio/cancelled.mp3')
                .then((_) => audioService.play());
            isCancelled = true;
            targetOffsetDx = 0.0;
            iconSacle = 1;
            recordService.cancelRecord();
          }
        });
      },

      onLongPressEnd: (_) async {
        if (!isCancelled) {
          audioService
              .loadAsset(assetPath: 'assets/audio/send.mp3')
              .then((_) => audioService.play());
          iconSacle = 1;
          final path = await recordService.stop();
          cubit.audio = File(path!);
          cubit.sendMsg(type: 2);
        }

        setState(() {
          context.read<ChatCubit>().changeRecordingState(isRecording: false);
          cubit.updateTargetOffest(dx: 0);
          isRecording = false;
          targetOffsetDx = 0.0;
          isCancelled = false;
        });
      },

      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0.0, end: targetOffsetDx),
        duration: Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: _buildMicWidget(),
        builder: (context, value, child) {
          return Transform.translate(offset: Offset(value, 0), child: child);
        },
      ),
    );
  }

  AnimatedScale _buildMicWidget() {
    return AnimatedScale(
      duration: Duration(milliseconds: 100),
      scale: iconSacle,
      child: Container(
        width: 55,
        height: 55,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [Color(0xFF6A11CB), Color(0xFF2575FC)],
          ),
        ),
        child: Icon(Icons.mic, color: AppColors.whiteColor),
      ),
    );
  }
}

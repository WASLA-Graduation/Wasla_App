import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:record/record.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/service/Audio/record_service.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/chat/presentation/widgets/audio_recorder_wave_widget.dart';
import 'package:wasla/features/chat/presentation/widgets/recorder_timer_widget.dart';

class AudioTest extends StatelessWidget {
  const AudioTest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox.expand(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 200,
              child: GeneralButton(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (context) => RepositoryProvider<RecordService>(
                      create: (context) => RecordService(),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Theme.of(context).scaffoldBackgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: const AudioRecorderTestBody(),
                      ),
                    ),
                  );
                },
                text: "Record",
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AudioRecorderTestBody extends StatefulWidget {
  const AudioRecorderTestBody({super.key});

  @override
  State<AudioRecorderTestBody> createState() => _AudioRecorderTestBodyState();
}

class _AudioRecorderTestBodyState extends State<AudioRecorderTestBody> {
  late final RecordService _recordService;
  @override
  void initState() {
    _recordService = context.read<RecordService>();
    _recordService.start();
    super.initState();
  }

  @override
  void deactivate() {
    _recordService.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.ltr,
      child: Column(
        spacing: 10,
        mainAxisSize: MainAxisSize.min,
        children: [
          AudioWaveWidget(),
          RecoderTimerWidget(),
          RecorderWidgtController(),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}

class RecorderWidgtController extends StatelessWidget {
  const RecorderWidgtController({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            context.read<RecordService>().cancelRecord().then((value) {
              context.pop();
              return null;
            });
            showToast(color: AppColors.green, 'Cancelled');
          },

          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            'cancel'.tr(context),
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
        StreamBuilder<RecordState>(
          stream: context.read<RecordService>().stateStream(),
          builder: (context, snapshot) {
            final state = snapshot.data == RecordState.record;
            return PlayPauseButton(
              onPressed: () {
                if (snapshot.data == RecordState.pause) {
                  context.read<RecordService>().resume();
                } else {
                  context.read<RecordService>().pause();
                }
              },
              isPlaying: state,
            );
          },
        ),

        GestureDetector(
          onTap: () async {
            // ignore: unused_local_variable
            final String? path = await context.read<RecordService>().stop();
            context.pop();
          },

          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            'save',
            style: Theme.of(context).textTheme.labelSmall,
          ),
        ),
      ],
    );
  }
}

class PlayPauseButton extends StatelessWidget {
  const PlayPauseButton({
    super.key,
    required this.isPlaying,
    required this.onPressed,
  });

  final bool isPlaying;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: AppColors.primaryColor,
      radius: 25,
      child: IconButton(
        icon: Icon(
          isPlaying ? Icons.pause : Icons.play_arrow,
          color: AppColors.whiteColor,
          size: 28,
        ),
        onPressed: onPressed,
      ),
    );
  }
}

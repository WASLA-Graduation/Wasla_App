import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/convert_time_to_natural_time.dart';
import 'package:wasla/core/service/Audio/record_service.dart';

class RecoderTimerWidget extends StatelessWidget {
  const RecoderTimerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<int>(
      initialData: 0,
      stream: context.read<RecordService>().outputStreamTimer,
      builder: (context, snapshot) {
        final int seconds = snapshot.data ?? 0;
        return Text(
          convertTimeToNaturalTimer(sec: seconds),
          style: Theme.of(context).textTheme.labelSmall,
        );
      },
    );
  }
}

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/service/Audio/record_service.dart';
import 'package:wasla/core/utils/app_colors.dart';

class AudioWaveWidget extends StatefulWidget {
  const AudioWaveWidget({super.key});

  @override
  State<AudioWaveWidget> createState() => _AudioWaveWidgetState();
}

class _AudioWaveWidgetState extends State<AudioWaveWidget> {
  late final RecordService _recordService;
  final ScrollController _scrollController = ScrollController();
  StreamSubscription<double>? _subscriptionAmplitude;
  List<double> amplitudes = [];
  double waveMaxHeight = 45;
  final double minAmplitude = -67;
  @override
  void initState() {
    _recordService = context.read<RecordService>();
    _subscriptionAmplitude = _recordService.amplitudeStream().listen((amp) {
      setState(() {
        amplitudes.add(amp);
        if (_scrollController.positions.isNotEmpty) {
          //check if the controller  is load before List
          _scrollController.animateTo(
            _scrollController.position.maxScrollExtent,
            duration: Duration(milliseconds: 175),
            curve: Curves.linear,
          );
        }
      });
    });

    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _subscriptionAmplitude?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: waveMaxHeight,
      child: ListView.separated(
        separatorBuilder: (context, index) => const SizedBox(width: 2),
        padding: EdgeInsets.symmetric(horizontal: 2),
        itemCount: amplitudes.length,
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          double amp = amplitudes[index].clamp(minAmplitude, 0);
          double ampPercentage = 1 - (amp / minAmplitude).abs();
          double waveHeight = waveMaxHeight * ampPercentage;
          return Center(
            child: TweenAnimationBuilder(
              duration: const Duration(milliseconds: 100),
              curve: Curves.decelerate,
              tween: Tween<double>(begin: 0, end: waveHeight),
              builder: (context, double height, child) {
                return SizedBox(height: height, width: 3, child: child);
              },
              child: DecoratedBox(
                decoration: BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

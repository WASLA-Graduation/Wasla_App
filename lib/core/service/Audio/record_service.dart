import 'dart:async';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:record/record.dart';
import 'package:uuid/uuid.dart';

class RecordService {
  Timer? _timer;
  int currentTime = 0;
  final AudioRecorder _recorder = AudioRecorder();
  final Uuid _uuid = Uuid();
  String? _currentPath;

  StreamController<int> timerStream = StreamController<int>.broadcast()..add(0);
  Stream<int> get outputStreamTimer => timerStream.stream;

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      currentTime++;
      timerStream.add(currentTime);
    });
  }

  void _reset() {
    _timer?.cancel();
    currentTime = 0;
    timerStream.add(0);
  }

  Future<String> _generatePath() async {
    final dir = await getApplicationDocumentsDirectory();
    final fileNam = "record_${_uuid.v4()}.m4a";
    return "${dir.path}/$fileNam";
  }

  Future<bool> _checkPermission() async {
    bool status = await Permission.microphone.isGranted;
    if (status) return true;

    final permissionStatus = await Permission.microphone.request();

    if (permissionStatus == PermissionStatus.permanentlyDenied) {
      await openAppSettings();
    }

    return permissionStatus == PermissionStatus.granted;
  }

  Future<void> start() async {
    final bool hasPermission = await _checkPermission();
    if (hasPermission) {
      _currentPath = await _generatePath();

      await _recorder.start(RecordConfig(), path: _currentPath!);
      _startTimer();
    }
  }

  Future<String?> stop() async {
    _reset();
    return await _recorder.stop() ?? _currentPath;
  }

  Future<void> pause() async {
    _timer!.cancel();
    return _recorder.pause();
  }

  Future<void> resume() async {
    _startTimer();
    return _recorder.resume();
  }

  Future<void> cancelRecord() async {
    final String? path = await stop();
    if (path != null) {
      final File file = File(path);
      await file.delete();
    }
  }

  Future<bool> isRecording() async => await _recorder.isRecording();

  Future<void> toggleRecord() async {
    if (await isRecording()) {
      await pause();
    } else {
      await start();
    }
  }

  Stream<double> amplitudeStream() {
    //  min     max
    // -67  => 0
    return _recorder
        .onAmplitudeChanged(const Duration(milliseconds: 200))
        .map((amp) => amp.current);
  }

  Stream<RecordState> stateStream() {
    return _recorder.onStateChanged();
  }

  Future<void> dispose() async {
    _timer?.cancel();
    _timer = null;
    timerStream.close();
    await _recorder.dispose();
  }
}

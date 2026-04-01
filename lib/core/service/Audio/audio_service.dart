import 'package:just_audio/just_audio.dart';

class AudioService {
  final AudioPlayer _audioPlayer = AudioPlayer();

  /// to play sound you must follow this steps
  /// 1- load sound
  /// 2- play sound
  /// 3- dispose

  bool get isPlaying => _audioPlayer.playing;

  ///get position of sound
  Duration get position => _audioPlayer.position;

  ///get the all duration of sound say 40 secondsF
  Duration? get duration => _audioPlayer.duration;

  double get speed => _audioPlayer.speed;
  double get volume => _audioPlayer.volume;

  ///check if sound is completed
  bool get isCompleted =>
      _audioPlayer.playerState.processingState == ProcessingState.completed;
  //the same previouse methods but with stream
  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;
  //Load to url of sound
  Future<void> loadUrl({required String url}) async {
    await _audioPlayer.setUrl(url);
  }

  //load to path of sound in this pc
  Future<void> loadAsset({required String assetPath}) async {
    await _audioPlayer.setAsset(assetPath);
  }

  //Load file from real device
  Future<void> loadFile({required String filePath}) async {
    await _audioPlayer.setFilePath(filePath);
  }

  ///play sound
  Future<void> play() async {
    await _audioPlayer.play();
  }

  ///stop sound
  Future<void> stop() async {
    await _audioPlayer.stop();
    await _audioPlayer.seek(Duration.zero);
  }

  ///pause sound
  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  ///check if sound is playing

  ///toggle sound
  Future<void> toggleSound() async {
    if (isPlaying) {
      await pause();
    } else {
      if (position >= (duration ?? Duration.zero)) {
        await seekTo(position: Duration.zero);
      }
      await play();
    }
  }

  ///going to specific position
  Future<void> seekTo({required Duration position}) async {
    await _audioPlayer.seek(position);
  }

  ///going to specific position forward with seconds
  Future<void> seekForwardSeconds({required int seconds}) async {
    final newPosition = position + Duration(seconds: seconds);
    final target = duration != null && newPosition > duration!
        ? duration!
        : newPosition;
    await _audioPlayer.seek(target);
  }

  ///going to specific position backward with seconds
  Future<void> seekBackwardSeconds({int seconds = 10}) async {
    final newPosition = position - Duration(seconds: seconds);
    final target = newPosition < Duration.zero ? Duration.zero : newPosition;
    await _audioPlayer.seek(target);
  }

  //control volume of sound
  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
  }

  //control speed of sound
  Future<void> setSpeed(double speed) async {
    await _audioPlayer.setSpeed(speed.clamp(0.5, 2.0));
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}

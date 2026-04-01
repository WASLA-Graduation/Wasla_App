import 'package:just_audio/just_audio.dart';

class ChatAudioService {
  ChatAudioService._instence();
  static final ChatAudioService _instance = ChatAudioService._instence();
  factory ChatAudioService() => _instance;

  final AudioPlayer _audioPlayer = AudioPlayer();

  String? currentPlayingMessageId;

  bool get isPlaying => _audioPlayer.playing;

  Duration get position => _audioPlayer.position;

  Duration? get duration => _audioPlayer.duration;

  double get speed => _audioPlayer.speed;
  double get volume => _audioPlayer.volume;

  bool get isCompleted =>
      _audioPlayer.playerState.processingState == ProcessingState.completed;

  Stream<Duration> get positionStream => _audioPlayer.positionStream;
  Stream<Duration?> get durationStream => _audioPlayer.durationStream;
  Stream<PlayerState> get playerStateStream => _audioPlayer.playerStateStream;

  Future<void> playRecord({
    required String url,
    required String messageId,
  }) async {
    if (currentPlayingMessageId == messageId) {
      if (isPlaying) {
        await pause();
      } else {
        if (position >= (duration ?? Duration.zero)) {
          await seekTo(position: Duration.zero);
        }
        await play();
      }
      return;
    }

    await stop();
    currentPlayingMessageId = messageId;

    await _audioPlayer.setUrl(url);
    await play();
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> stop() async {
    await _audioPlayer.stop();
    await _audioPlayer.seek(Duration.zero);
    currentPlayingMessageId = null;
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> seekTo({required Duration position}) async {
    await _audioPlayer.seek(position);
  }

  Future<void> seekForwardSeconds({required int seconds}) async {
    final newPosition = position + Duration(seconds: seconds);
    final target = duration != null && newPosition > duration!
        ? duration!
        : newPosition;
    await _audioPlayer.seek(target);
  }

  Future<void> seekBackwardSeconds({int seconds = 10}) async {
    final newPosition = position - Duration(seconds: seconds);
    final target = newPosition < Duration.zero ? Duration.zero : newPosition;
    await _audioPlayer.seek(target);
  }

  Future<void> setVolume(double volume) async {
    await _audioPlayer.setVolume(volume.clamp(0.0, 1.0));
  }

  Future<void> setSpeed(double speed) async {
    await _audioPlayer.setSpeed(speed.clamp(0.5, 2.0));
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }
}

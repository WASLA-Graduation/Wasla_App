import 'dart:isolate';

class IsolateManager {
  ReceivePort? _receivePort;
  ReceivePort? _errorPort;
  ReceivePort? _exitPort;
  Isolate? _isolate;

  bool get isRunning => _isolate != null;

  Future<void> start(
    void Function(IsolatesMessage) callback,
    dynamic data, {
    required Function(dynamic error) onError,
    required Function(dynamic message) onData,
  }) async {
    if (isRunning) stop();

    _receivePort = ReceivePort();
    _errorPort = ReceivePort();
    _exitPort = ReceivePort();

    _receivePort?.listen((data) => onData(data));
    _errorPort?.listen((data) {
      onError(data);
      _close();
    });
    _exitPort?.listen((_) => _close());

    _isolate = await Isolate.spawn(
      callback,
      IsolatesMessage(sendPort: _receivePort!.sendPort, data: data),
      onError: _errorPort?.sendPort,
      onExit: _exitPort?.sendPort,
      
    );
  }

  void stop() => _close();

  void _close() {
    _receivePort?.close();
    _errorPort?.close();
    _exitPort?.close();
    _isolate?.kill();
    _isolate = null;
  }
}

class IsolatesMessage {
  final SendPort sendPort;
  final dynamic data;

  IsolatesMessage({required this.sendPort, required this.data});
}

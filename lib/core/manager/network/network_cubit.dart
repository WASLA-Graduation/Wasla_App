import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/connection/network_info.dart';
part 'network_state.dart';

class NetworkCubit extends Cubit<NetworkState> {
  NetworkCubit(this.networkInfo) : super(NetworkInitial()) {
    listenToNetwork();
  }

  bool isFirstCheck = true;

  final NetworkInfo networkInfo;
  StreamSubscription<bool>? _subscription;

  void listenToNetwork() {
    _subscription = networkInfo.onConnectivityChanged.listen((isConnected) {
      if (isFirstCheck) {
        isFirstCheck = false;
        if (!isConnected) {
          emit(NetworkDisconnected());
        }
      } else {
        isConnected ? emit(NetworkConnected()) : emit(NetworkDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

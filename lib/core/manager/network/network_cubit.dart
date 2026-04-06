import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/connection/network_info.dart';
import 'package:wasla/core/database/cache/shared_preferences_helper.dart';
import 'package:wasla/core/utils/app_strings.dart';
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
      final bool isSignIn =
          SharedPreferencesHelper.get(key: AppStrings.isSingedIn) as bool? ??
          false;
      if (isSignIn) {
        if (isFirstCheck) {
          isFirstCheck = false;
          if (!isConnected) {
            emit(NetworkDisconnected());
          }
        } else {
          isConnected ? emit(NetworkConnected()) : emit(NetworkDisconnected());
        }
      }
    });
  }

  @override
  Future<void> close() {
    _subscription?.cancel();
    return super.close();
  }
}

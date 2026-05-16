import 'dart:developer';

import 'package:signalr_netcore/signalr_client.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DriverHub {
  late HubConnection hubConnection;

  Future<void> init() async {
    hubConnection = HubConnectionBuilder()
        .withUrl(
          "https://waslammka.runasp.net/rideHub",
          options: HttpConnectionOptions(
            accessTokenFactory: () async {
              final token = await SecureStorageHelper.get(key: ApiKeys.token);

              return token ?? '';
            },
          ),
        )
        .withAutomaticReconnect()
        .build();

    addListeners();

    try {
      await hubConnection.start();

      toastAlert(color: AppColors.green, msg: "Connected to SignalR");
    } catch (e) {
      toastAlert(color: AppColors.red, msg: "SignalR connection error: $e");
    }

    hubConnection.onclose(({error}) {
      toastAlert(
        color: AppColors.red,
        msg: "SignalR connection closed: $error",
      );
    });
  }

  void addListeners() {
    /// 🚖 Ride Accepted
    hubConnection.on("RideAccepted", (data) {
      if (data == null || data.isEmpty) return;
      final rideId = data[0] as int;

      // log("Ride Id : $rideId");

      // log(ride.toString());

      // navigatorKey.currentContext?.pushNamed(
      //   AppRoutes.driverTripDetailsScreen,
      //   extra: rideId,
      // );
    });
  }

  Future<void> disconnect() async {
    await hubConnection.stop();
  }
}

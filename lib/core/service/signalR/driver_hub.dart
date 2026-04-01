import 'package:flutter/material.dart';
import 'package:signalr_netcore/signalr_client.dart';
import 'package:wasla/core/database/api/api_keys.dart';
import 'package:wasla/core/database/cache/secure_storage_helper.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';

class DriverHub {
  late HubConnection hubConnection;

  void init() async {
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

    try {
      listenToAcceptRide();
      await hubConnection.start();
      // toastAlert(color: AppColors.red, msg: "Connected to SignalR");
    } catch (e) {
      toastAlert(color: AppColors.red, msg: "SignalR connection error: $e");
    }
    hubConnection.onclose(({error}) {
      toastAlert(color: AppColors.red, msg: "SignalR connection error: $error");
    });
  }

  void listenToAcceptRide() {
    hubConnection.on("RideAccepted", (args) {
      if (args != null && args.isNotEmpty) {
        final data = args[0];

        debugPrint("🔥 Ride Accepted Event 🔥");
        debugPrint(data.toString());
      }
    });
  }
  // navigatorKey.currentContext?.pushNamed(
  //   AppRoutes.driverTripDetailsScreen,
  //   extra: data["id"],
  // );

  void disconnect() async {
    await hubConnection.stop();
  }
}

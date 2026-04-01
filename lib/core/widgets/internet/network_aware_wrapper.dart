import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/manager/network/network_cubit.dart';

class NetworkAwareWrapper extends StatelessWidget {
  final Widget child;
  const NetworkAwareWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return BlocListener<NetworkCubit, NetworkState>(
      listener: (context, state) {
        if (state is NetworkDisconnected) {
          // NoInternetOverlay.show(context);
          // toastAlert(msg: 'No Internet Connection', color: Colors.red);

          showToast('No IneternetConnecton', color: Colors.red);
        } else if (state is NetworkConnected) {
          // NoInternetOverlay.hide();
          // toastAlert(msg: 'Internet Connection Restored', color: Colors.green);
          showToast('Internet Connection Restored', color: Colors.green);
        }
      },
      child: child,
    );
  }
}

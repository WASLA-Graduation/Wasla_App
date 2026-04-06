import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';

class NoInternetWidget extends StatelessWidget {
  final VoidCallback onRetry;
  const NoInternetWidget({super.key, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(Icons.wifi_off, size: 80, color: Colors.blue),
          const SizedBox(height: 16),
          Text(
            'noInternet'.tr(context),
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('noInternetMessage'.tr(context)),
          const SizedBox(height: 24),
          ElevatedButton(onPressed: onRetry, child: Text('retry'.tr(context))),
        ],
      ),
    );
  }
}

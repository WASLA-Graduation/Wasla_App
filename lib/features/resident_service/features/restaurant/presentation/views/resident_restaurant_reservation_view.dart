import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/table%20reservatoin/resident_res_reservation_body.dart';

class ResidentRestaurantReservationView extends StatelessWidget {
  const ResidentRestaurantReservationView({
    super.key,
    required this.restaurantId,
  });
  final String restaurantId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('reservation'.tr(context))),

      body: ResidentRestaurantReservationViewBody(restaurantId: restaurantId),
    );
  }
}

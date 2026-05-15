import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';
import 'package:wasla/features/resident_service/features/restaurant/data/models/Update_restaurant_reservation_model.dart';

class CustomUpdateReservationButton extends StatelessWidget {
  const CustomUpdateReservationButton({super.key, required this.model});

  final GeneralResidentBookingsModel model;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        int numberOfPersons = getNumberOfPersons();
        context.pushScreen(
          AppRoutes.updateReservationScreen,
          arguments: UpdateRestaurantReservationModel(
            reservationId: model.baseBookingId,
            numberOfPersons: numberOfPersons,
            reservationDate: extractFromStringOnly(model.baseDate!)['date'],
            reservationTime: extractFromStringOnly(model.baseDate!)['time'],
          ),
        );
      },
      child: Container(
        width: 60,
        height: 25,
        decoration: ShapeDecoration(
          color: AppColors.orange,
          shape: StadiumBorder(),
        ),

        child: Center(
          child: Text(
            "update".tr(context),
            style: TextStyle(fontSize: 12, color: AppColors.whiteColor),
          ),
        ),
      ),
    );
  }

  int getNumberOfPersons() {
    final s = model.baseServiceName.split(' ').first;
    return int.parse(s);
  }

  Map<String, dynamic> extractFromStringOnly(String displayString) {
    final parts = displayString.split(' | ');

    final datePart = parts[0];
    final year = DateTime.now().year;
    final DateTime dateTime = DateFormat(
      "dd MMM yyyy",
    ).parse("$datePart $year");

    final timePart = parts[2];
    final parsedTime = DateFormat("h:mm a").parse(timePart);
    final TimeOfDay timeOfDay = TimeOfDay(
      hour: parsedTime.hour,
      minute: parsedTime.minute,
    );

    return {'date': dateTime, 'time': timeOfDay};
  }
}

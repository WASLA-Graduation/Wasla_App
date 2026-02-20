import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/booking/data/models/general_resident_bookings_model.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/custom_resdient_canceld_button.dart';

class BookingItemData extends StatelessWidget {
  const BookingItemData({
    super.key,
    required this.isUpcoming,
    required this.model,
    required this.index,
  });
  final bool isUpcoming;
  final GeneralResidentBookingsModel model;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWidget(context),
        _buildSpecialityWidget(context),
        _buildDateAndTimeWidget(context),
      ],
    );
  }

  Text _buildSpecialityWidget(BuildContext context) {
    return Text(
      maxLines: 1,
      overflow: TextOverflow.clip,
      "${model.baseServiceName}  |  ${model.baseStatus.tr(context)}",
      style: Theme.of(
        context,
      ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
    );
  }

  Row _buildTitleWidget(BuildContext context) {
    return Row(
      spacing: 10,
      children: [
        Expanded(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            model.baseName,
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        CustomResidentCancelButton(
          isUpcoming: isUpcoming,
          bookingId: model.baseBookingId,
          index: index,
        ),
      ],
    );
  }

  Column _buildDateAndTimeWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 3,
      children: [
        Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          // "${formatStringDate(model.date)} ${localizedDays(index: model.day)} ",
          model.baseDate!,
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
        ),
        Text(
          maxLines: 2,
          overflow: TextOverflow.ellipsis,

          // "${convertBackendTimeToAmPm(model.start)} : ${convertBackendTimeToAmPm(model.end)}",
          model.baseDuration!,
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
        ),
      ],
    );
  }
}



// Container(
//           width: 60,
//           height: 25,
//           decoration: ShapeDecoration(shape: StadiumBorder()),

//           child: Center(
//             child: Text(
//               model.baseStatus.tr(context),
//               style: TextStyle(fontSize: 12, color: AppColors.gray),
//             ),
//           ),
//         ),
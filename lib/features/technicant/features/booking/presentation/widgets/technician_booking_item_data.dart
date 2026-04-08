import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/technicant/features/booking/presentation/widgets/technicain_booking_cancel_button.dart';

class TechnicianBookingListItemData extends StatelessWidget {
  const TechnicianBookingListItemData({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 6,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleWidget(context),
        _buildSpecialityWidget(context),
        _buildDateAndTimeWidget(context),
      ],
    );
  }

  Row _buildSpecialityWidget(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Text(
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            "${"Disha"} ",
            style: Theme.of(
              context,
            ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
          ),
        ),
        Text(
          " |   ${"Pending"} ",
          style: Theme.of(
            context,
          ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
        ),
      ],
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
            "Plumbing",
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700),
          ),
        ),
        Visibility(
          child: TechnicianBookingCancelOrAcceptButton(
            text: "accept".tr(context),
            color: AppColors.primaryColor,
            onTap: () {},
          ),
        ),
      ],
    );
  }

  Row _buildDateAndTimeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            spacing: 3,
            children: [
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '12 jan | tue',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
              ),
              Text(
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                '10:00 Am',
                style: Theme.of(
                  context,
                ).textTheme.labelSmall!.copyWith(color: AppColors.gray),
              ),
            ],
          ),
        ),
        Visibility(
          child: TechnicianBookingCancelOrAcceptButton(
            text: "cancel".tr(context),
            color: AppColors.red,
            onTap: () {},
          ),
        ),
      ],
    );
  }
}

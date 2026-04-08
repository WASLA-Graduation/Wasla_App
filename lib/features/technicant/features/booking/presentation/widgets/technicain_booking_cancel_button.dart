import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_bottom_sheet_confirm_widget.dart';

class TechnicianBookingCancelOrAcceptButton extends StatelessWidget {
  const TechnicianBookingCancelOrAcceptButton({
    super.key,
    required this.onTap,
    required this.color,
    required this.text,
    required this.isCancel,
  });

  final VoidCallback onTap;
  final Color color;
  final String text;
  final bool isCancel;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        if (isCancel) {
          showModalBottomSheet(
            context: context,
            builder: (_) => CustomBottomSheetConfirmWidget(
              cancelText: 'cancel'.tr(context),
              confirmText: 'confirm'.tr(context),
              onConfirm: () {
                Navigator.pop(context);
                onTap();
              },
              title: 'cancelBooking'.tr(context),
              description: 'areYouSureCancel'.tr(context),
            ),
          );
        } else {
          onTap();
        }
      },
      child: Container(
        width: 60,
        height: 25,
        decoration: ShapeDecoration(color: color, shape: StadiumBorder()),

        child: Center(
          child: Text(
            text,
            style: TextStyle(fontSize: 12, color: AppColors.whiteColor),
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_choose_time_widget.dart';

class CustomChooseTimeDocServiceWidget extends StatelessWidget {
  const CustomChooseTimeDocServiceWidget({
    super.key,
    required this.to,
    required this.from,
    required this.dateChangeFrom,
    required this.dateChangeTo,
    this.onDelete,
  });
  final TimeOfDay to;
  final TimeOfDay from;
  final void Function(TimeOfDay) dateChangeFrom;
  final void Function(TimeOfDay) dateChangeTo;
  final VoidCallback? onDelete;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: CustomChooseTimeWidget(
            text: 'from'.tr(context),
            dateChange: dateChangeFrom,
            selectedTime: to,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: CustomChooseTimeWidget(
            text: 'to'.tr(context),
            dateChange: dateChangeTo,
            selectedTime: from,
          ),
        ),
        const SizedBox(width: 10),
        Transform.translate(
          offset: const Offset(0, -15),
          child: InkWell(
            onTap: onDelete,
            child: Image.asset(
              Assets.assetsImagesDelete,
              height: 24,
              width: 24,
            ),
          ),
        ),
      ],
    );
  }
}

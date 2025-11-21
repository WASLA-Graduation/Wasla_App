import 'package:flutter/cupertino.dart';

import 'package:wasla/core/utils/app_colors.dart';

class CustomSwitchButton extends StatelessWidget {
  const CustomSwitchButton({
    super.key,
    required this.onChanged,
    required this.value,
  });
  final void Function(bool)? onChanged;
  final bool value;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: 0.8,
      child: Transform.translate(
        offset: Offset(20, 0),
        child: CupertinoSwitch(
          inactiveThumbColor: AppColors.whiteColor,
          inactiveTrackColor: AppColors.grayDark.withOpacity(0.2),
          activeTrackColor: AppColors.primaryColor,
          value: value,
          onChanged: onChanged,
        ),
      ),
    );
  }
}

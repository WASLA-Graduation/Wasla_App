import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/profile/presentation/widgets/bottom_sheet_logout_widget.dart';

class CustomLogoutWidget extends StatelessWidget {
  const CustomLogoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (_) => BottomSheetLogoutWidget(),
        );
      },
      child: Row(
        children: [
          Image.asset(
            Assets.assetsImagesLogout,
            height: 24,
            width: 24,
            color: Colors.red,
          ),
          const SizedBox(width: 16),
          Text(
            "logout".tr(context),
            style: Theme.of(
              context,
            ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}

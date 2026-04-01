import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/enum_colors.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';

class DropDownColors extends StatelessWidget {
  final Function(int color) onSelected;
  final String? title;

  const DropDownColors({super.key, required this.onSelected, this.title});

  @override
  Widget build(BuildContext context) {
    return CustomDropDownMenu(
      initialSelection: title,
      hint: "selectColor".tr(context),
      items: EnumColors.values
          .map(
            (item) => DropDownItem(
              label: item.name.tr(context),
              value: item.index.toString(),
            ),
          )
          .toList(),
      onSelecte: (color) {
        if (color != null) {
          onSelected(int.parse(color));
        }
      },
    );
  }
}

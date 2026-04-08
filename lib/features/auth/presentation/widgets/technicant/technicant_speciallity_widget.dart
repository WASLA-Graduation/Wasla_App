import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/technicant_speciality.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';

class TechnicantSpecialityWidget extends StatelessWidget {
  const TechnicantSpecialityWidget({
    super.key,
    this.initialValue,
    required this.onSelect,
  });

  final String? initialValue;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    return CustomDropDownMenu(
      initialSelection: initialValue,
      hint: "specialty".tr(context),
      items: TechnicantSpeciality.values
          .map(
            (speciality) => DropDownItem(
              label: TechnicantSpeciality.getTitle(
                index: speciality.index,
              ).tr(context),
              value: speciality.index.toString(),
            ),
          )
          .toList(),
      onSelecte: (specialty) {
        onSelect(specialty ?? '1');
      },
    );
  }
}

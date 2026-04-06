import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/technicant_speciality.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';

class TechnicantSpecialityWidget extends StatelessWidget {
  const TechnicantSpecialityWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocBuilder<AuthCubit, AuthState>(
      buildWhen: (previous, current) =>  current is AuthUpdateTechnicantSpecialization,
      builder: (context, state) {
        return CustomDropDownMenu(
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
            cubit.updateTechnicantSpeciality(
              speciality: int.parse(specialty ?? "-1"),
            );
          },
        );
      },
    );
  }
}

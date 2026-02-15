import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/auth/data/models/drop_down_menu_item.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_drop_down_menu.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_type_model.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';

class GymChooseTypeDropDown extends StatelessWidget {
  const GymChooseTypeDropDown({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymPackagesCubit>();
    return BlocBuilder<GymPackagesCubit, GymPackagesState>(
      builder: (context, state) {
        return CustomDropDownMenu(
          initialSelection: cubit.gymPackagTypeValue.toString(),
          items: GymPackageTypeModel.types
              .map(
                (type) => DropDownItem(
                  label: type.type,
                  value: type.value.toString(),
                ),
              )
              .toList(),

          onSelecte: (type) {
            cubit.updateGymPackageTypeValue(value: int.tryParse(type!)!);
          },
        );
      },
    );
  }
}

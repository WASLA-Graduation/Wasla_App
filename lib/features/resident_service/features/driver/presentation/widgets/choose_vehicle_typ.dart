import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/driver_enums.dart';
import 'package:wasla/core/widgets/custom_radio_button_list.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';

class ChooseVehicleType extends StatelessWidget {
  const ChooseVehicleType({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentDriverCubit>();
    return BlocBuilder<ResidentDriverCubit, ResidentDriverState>(
      buildWhen: (previous, current) =>
          current is ResidentDriverChangeVehicleType,

      builder: (context, state) {
        return CustomRadioList<VehicleType>(
          values: VehicleType.values,
          groupValue: cubit.vehicleType,
          onChanged: (value) {
            cubit.changeVehicleType(type: value);
            context.pop();
          },
          titleBuilder: (value) {
            return VehicleType.getTitle(value.index).tr(context);
          },
        );
      },
    );
  }
}

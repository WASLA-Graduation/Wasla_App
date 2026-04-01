import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/driver_enums.dart';
import 'package:wasla/core/widgets/under_line_widget.dart';
import 'package:wasla/features/driver/features/trip/presentation/widgets/suggested_trip_data_box.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/choose_vehicle_typ.dart';

class ResidentChooseVehicleTypeButton extends StatelessWidget {
  const ResidentChooseVehicleTypeButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        showModalBottomSheet(
          context: context,
          builder: (context) => Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Theme.of(context).scaffoldBackgroundColor,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(40),
                topRight: Radius.circular(40),
              ),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              spacing: 8,
              children: [UnderLineWidget(), ChooseVehicleType()],
            ),
          ),
        );
      },
      child: BlocBuilder<ResidentDriverCubit, ResidentDriverState>(
        buildWhen: (previous, current) =>
            current is ResidentDriverChangeVehicleType,
        builder: (context, state) {
          return SuggestedTripBoxData(
            title: 'vechileType'.tr(context),
            data: VehicleType.getTitle(
              context.read<ResidentDriverCubit>().vehicleType.index,
            ).tr(context),
          );
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/enter_locatoin_textfield.dart';

class EnterLocationFields extends StatelessWidget {
  const EnterLocationFields({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResidentDriverCubit>();
    return Column(
      spacing: 10,
      children: [
        BlocBuilder<ResidentDriverCubit, ResidentDriverState>(
          buildWhen: (previous, current) =>
              current is ResidentDriverGetMyLocationSuccessState,
          builder: (context, state) {
            return EnterLocationTextField(
              hintText: "fromCap".tr(context),
              cursorColor: Colors.green,
              onChanged: (value) {
                cubit.isFromField = true;
                cubit.updateButtonState();
                cubit.searchToPlace(value);
              },

              controller: cubit.fromController,
              suffixIcon: cubit.myLocation != null
                  ? IconButton(
                      onPressed: () {
                        cubit.chooseMyLocation();
                        cubit.fromController.text = 'myLocation'.tr(context);
                      },
                      icon: Icon(Icons.my_location, color: Colors.green),
                    )
                  : null,
            );
          },
        ),
        EnterLocationTextField(
          hintText: "to".tr(context),
          cursorColor: Colors.red,
          onChanged: (value) {
            cubit.isFromField = false;
            cubit.updateButtonState();
            cubit.searchToPlace(value);
          },
          controller: cubit.toController,
        ),
      ],
    );
  }
}

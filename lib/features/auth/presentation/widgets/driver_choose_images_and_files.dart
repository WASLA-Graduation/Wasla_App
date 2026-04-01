import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/driver_enums.dart';
import 'package:wasla/core/widgets/choose_many_files_widget.dart';
import 'package:wasla/core/widgets/choose_many_images.dart';
import 'package:wasla/core/widgets/custom_radio_button_list.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

class DriverChooseFilesAndImages extends StatelessWidget {
  const DriverChooseFilesAndImages({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return Column(
      children: [
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return ChooseManyImageWidget(
              images: cubit.gymImages,
              hintText: "vechileImages".tr(context),
              onImagesSelected: (images) {
                cubit.uploadIImages(images);
              },
            );
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            return ChooseManyFilesWidget(
              files: cubit.driverFiles,
              hintText: "driverFiles".tr(context),
              onFilesSelected: (files) {
                cubit.uploadFiles(files);
              },
            );
          },
        ),
        const SizedBox(height: 20),
        // ChooseVehicleType(),
        BlocBuilder<AuthCubit, AuthState>(
          builder: (context, state) {
            final cubit = context.read<AuthCubit>();
            return CustomRadioList<VehicleType>(
              values: VehicleType.values,
              groupValue: cubit.vehicleType,
              onChanged: (value) {
                cubit.updateVehicleType(type: value);
              },
              titleBuilder: (value) {
                return VehicleType.getTitle(value.index).tr(context);
              },
            );
          },
        ),
      ],
    );
  }
}

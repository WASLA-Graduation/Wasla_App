import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/driver_enums.dart';
import 'package:wasla/core/widgets/choose_many_files_widget.dart';
import 'package:wasla/core/widgets/choose_many_images.dart';
import 'package:wasla/core/widgets/custom_radio_button_list.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class DriverUpdateProfileFilesTypeCar extends StatelessWidget {
  const DriverUpdateProfileFilesTypeCar({super.key, required this.driver});
  final DriverProfileModel driver;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    cubit.vehicleType = VehicleType.values[driver.vehicleType];
    return Column(
      children: [
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return ChooseManyImageWidget(
              images: cubit.images,
              hintText: driver.carImages.isEmpty
                  ? "vechileImages".tr(context)
                  : driver.carImages.length.toString(),
              onImagesSelected: (images) {
                cubit.uploadIImages(images);
              },
            );
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return ChooseManyFilesWidget(
              files: cubit.files,
              hintText: driver.driverFiles.isEmpty
                  ? "driverFiles".tr(context)
                  : driver.driverFiles.length.toString(),
              onFilesSelected: (files) {
                cubit.uploadFiles(files);
              },
            );
          },
        ),
        const SizedBox(height: 20),
        BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            return CustomRadioList<VehicleType>(
              values: VehicleType.values,
              groupValue: cubit.vehicleType,
              onChanged: (value) {
                cubit.updateVehicleType(value);
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

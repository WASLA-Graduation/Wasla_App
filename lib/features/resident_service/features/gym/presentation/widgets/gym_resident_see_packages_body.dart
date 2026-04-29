import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/gym_package_item.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';

class ResidentGymSeePakcagesViewBody extends StatelessWidget {
  const ResidentGymSeePakcagesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymResidentCubit>();
    return BlocBuilder<GymResidentCubit, GymResidentState>(
      buildWhen: (previous, current) =>
          current is GymResidentGetGymPackagesSuccess ||
          current is GymResidentGetGymPackagesLoading,
      builder: (context, state) {
        if (state is GymResidentGetGymPackagesLoading ||
            state is GymResidentInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.gymPackages.isEmpty
              ? EmptyStateWidget()
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.marginDefault,
                    vertical: AppSizes.paddingSizeEight,
                  ),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 10,
                          crossAxisSpacing: 10,
                          mainAxisExtent: 300,
                        ),
                    itemCount: cubit.gymPackages.length,
                    // itemCount: 5,
                    itemBuilder: (context, index) => GymPackageItem(
                      withBookingButton: true,
                      model: cubit.gymPackages[index],
                    ),
                  ),
                );
        }
      },
    );
  }
}

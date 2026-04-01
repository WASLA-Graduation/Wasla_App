import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/custom_plusing_animation_widget.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/enter_your_location_simulate_widget.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/resident_current_location_map.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class ResidentDriverBody extends StatelessWidget {
  const ResidentDriverBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Stack(
            children: [
              ResidentCurrentLocationMap(),
              BlocBuilder<ResidentDriverCubit, ResidentDriverState>(
                buildWhen: (previous, current) =>
                    current is ResidentDriverGetMyLocationSuccessState,
                builder: (context, state) {
                  return Visibility(
                    visible:
                        context.read<ResidentDriverCubit>().myLocation == null,
                    child: Align(
                      child: PulsingAvatar(
                        withImage: true,
                        imageUrl:
                            context.read<HomeResidentCubit>().user?.imageUrl ??
                            '',
                        size: 110,
                        glowColor: AppColors.primaryColor,
                      ),
                    ),
                  );
                },
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: EnterYourLocationSimulateWidget(),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

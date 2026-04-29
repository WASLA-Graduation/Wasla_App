import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/resident_gym_card_widget.dart';

class ResidentGymDetailsViewBody extends StatelessWidget {
  const ResidentGymDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymResidentCubit, GymResidentState>(
      buildWhen: (previous, current) =>
          current is GymResidentGetGymDetailsSuccess,
      builder: (context, state) {
        final cubit = context.read<GymResidentCubit>();

        if (cubit.gym == null) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return ResidentGymCardWidget(gym: cubit.gym!);
        }
      },
    );
  }
}

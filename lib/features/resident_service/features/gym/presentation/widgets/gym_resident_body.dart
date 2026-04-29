import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/resident_gym_list.dart';

class GymResidentViewBody extends StatelessWidget {
  const GymResidentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymResidentCubit, GymResidentState>(
      buildWhen: (previous, current) =>
          current is GymResidentGetAllGymsLoading ||
          current is GymResidentGetAllGymsSuccess,
      builder: (context, state) {
        final cubit = context.read<GymResidentCubit>();

        if (state is GymResidentGetAllGymsLoading ||
            state is GymResidentInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.allGyms.isEmpty
              ? EmptyStateWidget(title: 'noGyms'.tr(context))
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.marginDefault,
                  ),
                  child: ResidentGymList(),
                );
        }
      },
    );
  }
}

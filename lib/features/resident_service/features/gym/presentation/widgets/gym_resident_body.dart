import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart' show SpinKitFadingCircle;
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_err_get_data.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/resident_gym_list.dart';

class GymResidentViewBody extends StatelessWidget {
  const GymResidentViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GymResidentCubit, GymResidentState>(
      builder: (context, state) {
        final cubit = context.read<GymResidentCubit>();

        if (state is GymResidentGetAllGymsFailure) {
          return CustomErrGetData();
        } else if (state is GymResidentGetAllGymsLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.allGyms.isEmpty
              ? Center(
                  child: Text(
                    "noGyms".tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : ResidentGymList(
                  isLoading:
                      state is GymResidentGetAllGymsFromPaginationLoading,
                );
        }
      },
    );
  }
}

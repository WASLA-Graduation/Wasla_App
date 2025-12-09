import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_list_item.dart';

class DoctorListWidget extends StatelessWidget {
  const DoctorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is DoctorGetBySpecialityListFailure ||
            state is DoctorGetSpecialityListFailure) {
          return Center(
            child: Column(
              children: [
                Image.asset(Assets.assetsImagesError, height: 200),
                const SizedBox(height: 20),
                FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(
                    "errorFetchData".tr(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          );
        } else if (state is DoctorGetBySpecialityListLoading ||
            state is DoctorGetSpecialityListLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.doctors.isEmpty
              ? Center(
                  child: Text(
                    "noDoctors".tr(context),
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 0),
                  separatorBuilder: (_, index) => const SizedBox(height: 5),
                  itemCount: cubit.doctors.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: InkWell(
                      onTap: () {
                        context.pushScreen(
                          AppRoutes.doctorDetailsScreen,
                          arguments: cubit.doctors[index],
                        );
                      },
                      child: cubit.doctors[index].imageUrl.isEmpty
                          ? const SizedBox()
                          : DoctorListItem(
                              index: index,
                              doctor: cubit.doctors[index],
                            ),
                    ),
                  ),
                );
        }
      },
    );
  }
}

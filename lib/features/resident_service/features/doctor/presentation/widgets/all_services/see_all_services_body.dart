import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/resident_doctor_service_item.dart';

class DoctorSeeSerevicesViewBody extends StatelessWidget {
  const DoctorSeeSerevicesViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        final cubit = context.read<DoctorCubit>();
        if (state is DoctorGetServicesListLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.services.isEmpty
              ? EmptyStateWidget(title: 'noServices'.tr(context))
              : Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: AppSizes.marginDefault,
                    vertical: AppSizes.paddingSizeDefault,
                  ),
                  child: ListView.separated(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 20),
                    itemCount: cubit.services.length,
                    separatorBuilder: (context, index) =>
                        const SizedBox(height: 10),
                    physics: const BouncingScrollPhysics(),

                    itemBuilder: (_, index) => InkWell(
                      onTap: () {
                        context.pushScreen(
                          AppRoutes.doctorBookingScreen,
                          arguments: cubit.services[index],
                        );
                      },
                      child: ResidentDoctorServiceItem(
                        doctorServiceModel: cubit.services[index],
                      ),
                    ),
                  ),
                );
        }
      },
    );
  }
}

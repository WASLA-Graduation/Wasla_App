import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/enums/event_type.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_list_item.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class DoctorListWidget extends StatelessWidget {
  const DoctorListWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorCubit>();
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        if (state is DoctorGetBySpecialityListLoading ||
            state is DoctorGetSpecialityListLoading) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else {
          return cubit.doctors.isEmpty
              ? EmptyStateWidget(title: 'noDoctors'.tr(context))
              : ListView.builder(
                  padding: const EdgeInsets.only(top: 0),
                  itemCount: cubit.doctors.length,
                  physics: BouncingScrollPhysics(),
                  itemBuilder: (_, index) => Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: InkWell(
                      onTap: () {
                        context.pushScreen(
                          AppRoutes.doctorDetailsScreen,
                          arguments: cubit.doctors[index],
                        );

                        context.read<HomeResidentCubit>().createUserEvent(
                          serviceProviderId: cubit.doctors[index].id,
                          eventType: EventType.viewDetails,
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

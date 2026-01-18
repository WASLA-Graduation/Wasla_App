import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/choose_doctor_booking_day.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/doc_choose_book_type.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/doctor_choose_booking_time_list.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class DoctorBookingViewBody extends StatelessWidget {
  const DoctorBookingViewBody({super.key, required this.doctorServiceModel});
  final DoctorServiceModel doctorServiceModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        return CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: ChooseDoctorBookingDay(
                serviceDayList: doctorServiceModel.serviceDays,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 15)),
            SliverToBoxAdapter(
              child: Text(
                "selectHour".tr(context),
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 15)),
            ChooseBookingTimeList(doctorServiceModel: doctorServiceModel),
            SliverToBoxAdapter(child: const SizedBox(height: 15)),
            SliverToBoxAdapter(
              child: Text(
                "${"bookingType".tr(context)} : ",
                style: Theme.of(context).textTheme.headlineMedium,
              ),
            ),
            SliverToBoxAdapter(child: const SizedBox(height: 10)),
            SliverToBoxAdapter(child: const DoctorChooseTypeOfBookig()),
            SliverFillRemaining(
              hasScrollBody: false,
              child: Column(
                children: [
                  const Spacer(),
                  BlocConsumer<DoctorCubit, DoctorState>(
                    listener: (context, state) {
                      if (state is DoctorBookServiceFailure) {
                        toastAlert(color: AppColors.error, msg: state.errMsg);
                      } else if (state is DoctorBookServiceSuccess) {
                        toastAlert(
                          color: AppColors.primaryColor,
                          msg: "bookingDone".tr(context),
                        );
                        context.popScreen();
                        context.popScreen();
                        context.popScreen();
                        context.read<HomeResidentCubit>().navBarcurrentIndex =
                            1;
                        context.popScreen();
                      }
                    },
                    builder: (context, state) {
                      return GeneralButton(
                        onPressed: () {
                          context.read<DoctorCubit>().bookService(
                            doctorServiceModel: doctorServiceModel,
                          );
                        },
                        text: state is DoctorBookServiceLoading
                            ? "loading".tr(context)
                            : "book".tr(context),
                      );
                    },
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/choose_doctor_booking_day.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/doc_choose_book_type.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/doctor_choose_booking_time_list.dart';
import 'package:wasla/features/resident_service/features/restaurant/presentation/widgets/checkout/checkout_payment_method.dart';

class DoctorBookingViewBody extends StatelessWidget {
  const DoctorBookingViewBody({super.key, required this.doctorServiceModel});
  final DoctorServiceModel doctorServiceModel;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<DoctorCubit, DoctorState>(
      builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: ChooseDoctorBookingDay(
                      serviceDayList: doctorServiceModel.serviceDays,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 15)),

                  SliverToBoxAdapter(
                    child: Text(
                      "selectHour".tr(context),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 15)),

                  ChooseBookingTimeList(doctorServiceModel: doctorServiceModel),

                  const SliverToBoxAdapter(child: SizedBox(height: 15)),

                  SliverToBoxAdapter(
                    child: Text(
                      "${"bookingType".tr(context)} : ",
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  const SliverToBoxAdapter(child: SizedBox(height: 10)),

                  const SliverToBoxAdapter(child: DoctorChooseTypeOfBookig()),

                  const SliverToBoxAdapter(child: SizedBox(height: 20)),

                  SliverToBoxAdapter(
                    child: Text(
                      'paymentMethod'.tr(context),
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                  ),
                  SliverToBoxAdapter(
                    child: SizedBox(height: AppSizes.paddingSizeFifteen),
                  ),

                  SliverToBoxAdapter(
                    child: BlocBuilder<DoctorCubit, DoctorState>(
                      buildWhen: (previous, current) =>
                          current is DoctortUpdatePaymentStauts,
                      builder: (context, state) {
                        final cubit = context.read<DoctorCubit>();

                        return PaymentMethodSelector(
                          groupValue: cubit.paymentMethod,
                          onChanged: (value) {
                            cubit.changePaymentMethod(value);
                          },
                        );
                      },
                    ),
                  ),

                  const SliverToBoxAdapter(child: SizedBox(height: 100)),
                ],
              ),
            ),

            BlocConsumer<DoctorCubit, DoctorState>(
              listener: (context, state) {
                if (state is DoctorBookServiceFailure) {
                  toastAlert(color: AppColors.error, msg: state.errMsg);
                } else if (state is DoctorBookServiceWithCashSuccess) {
                  toastAlert(
                    color: AppColors.primaryColor,
                    msg: "bookingDone".tr(context),
                  );
                  context.popScreen();
                  context.popScreen();
                }
              },
              builder: (context, state) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GeneralButton(
                      onPressed: () {
                        context.read<DoctorCubit>().bookService(
                          doctorServiceModel: doctorServiceModel,
                        );
                      },
                      text: state is DoctorBookServiceLoading
                          ? "loading".tr(context)
                          : "book".tr(context),
                    ),
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}

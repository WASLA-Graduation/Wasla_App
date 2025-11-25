import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/custom_choose_time_doc_service_widget.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/date_timeline_picker.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doc_add_service_form.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doc_weak_day_widget.dart';

class AddServiceViewBody extends StatelessWidget {
  const AddServiceViewBody({super.key, this.doctorServiceModel});
  final DoctorServiceModel? doctorServiceModel;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<DoctorServiceMangementCubit>();
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 15, 20, 0),
      child: Column(
        children: [
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                DateTimelinePicker(
                  title: "selectDate".tr(context),
                  initialSelectedDate: isEdit()
                      ? DateTime.parse(
                          doctorServiceModel!.serviceDates.first.date,
                        )
                      : DateTime.now(),
                ),
                const SizedBox(height: 15),
                CustomChooseTimeDocServiceWidget(
                  selectedTime: isEdit()
                      ? doctorServiceModel!.timeSlots.first
                      : null,
                ),
                const SizedBox(height: 10),
                CustomWeakDaysWidget(
                  daysIndex: isEdit()
                      ? doctorServiceModel!.serviceDays
                            .map((e) => e.dayOfWeek)
                            .toList()
                      : null,
                ),
                const SizedBox(height: 20),
                CustomDoctorAddServiceForm(model: doctorServiceModel),
                const SizedBox(height: 20),
              ],
            ),
          ),
          const SizedBox(height: 20),
          BlocConsumer<
            DoctorServiceMangementCubit,
            DoctorServiceMangementState
          >(
            listener: (context, state) {
              if (state is DoctorServiceMangementAddOrUpdateServiceFailure) {
                toastAlert(color: AppColors.error, msg: state.errorMessage);
              } else if (state
                  is DoctorServiceMangementAddOrUpdateServiceSuccess) {
                isEdit()
                    ? toastAlert(color: AppColors.green, msg: "Successfully")
                    : Navigator.pop(context);
              }
            },
            builder: (context, state) {
              return GeneralButton(
                onPressed: () {
                  cubit.checkDaysSelected();
                  if (cubit.addServiceFormKey.currentState!.validate() &&
                      cubit.daysSelected!) {
                    isEdit()
                        ? cubit.updateDoctorService(
                            service: doctorServiceModel!,
                          )
                        : cubit.addDoctorService();
                  }
                },
                text: state is DoctorServiceMangementAddOrUpdateServiceLoading
                    ? "sending".tr(context)
                    : isEdit()
                    ? "update".tr(context)
                    : "add".tr(context),
              );
            },
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  bool isEdit() {
    return doctorServiceModel != null;
  }
}

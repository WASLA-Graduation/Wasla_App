import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/views/edit_doctor_service_view.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doc_remove_service_dialog.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doc_service_item_header.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doctor_day_widget.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doctor_service_button.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doctor_tiems_widget.dart';

class DocServiceItem extends StatelessWidget {
  const DocServiceItem({super.key, required this.doctorServiceModel});
  final DoctorServiceModel doctorServiceModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      margin: const EdgeInsets.only(bottom: 20),
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDarkMode ? AppColors.blackColor : AppColors.whiteColor,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        spacing: 12,
        children: [
          DocServiceItemHeader(
            seviceName: context.isArabic
                ? doctorServiceModel.serviceNameAr
                : doctorServiceModel.serviceNameEn,
            sevicePrice: doctorServiceModel.price,
          ),
          DoctorDaysList(serviceDay: doctorServiceModel.serviceDays),
          DoctorTimesWidget(
            serviceDates: doctorServiceModel.serviceDates,
            timeSlots: doctorServiceModel.timeSlots,
          ),
          Divider(color: AppColors.gray, thickness: 0.2),
          Row(
            children: [
              Expanded(
                child: DoctorServiceButton(
                  onTap: () {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => EditDoctorServiceView(
                          doctorServiceModel: doctorServiceModel,
                        ),
                      ),
                    );
                  },
                  text: "edit".tr(context),
                  isDeleteButton: false,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: DoctorServiceButton(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (_) => DoctorRemoveServiceDialog(
                        serviceNameAR: doctorServiceModel.serviceNameAr,
                        serviceNameEn: doctorServiceModel.serviceNameEn,
                        serviceId: doctorServiceModel.id,
                      ),
                    );
                  },
                  text: "delete".tr(context),
                  isDeleteButton: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

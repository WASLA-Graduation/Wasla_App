import 'package:flutter/material.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doc_service_item_header.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doctor_day_widget.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doctor_service_button.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/doctor_tiems_widget.dart';

class DocServiceItem extends StatelessWidget {
  const DocServiceItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
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
        spacing: 15,
        children: [
          DocServiceItemHeader(),
          DoctorDaysList(),
          DoctorTimesWidget(),
          Divider(color: AppColors.gray, thickness: 0.2),
          Row(
            children: [
              Expanded(
                child: DoctorServiceButton(
                  onTap: () {},
                  text: "Edit",
                  isDeleteButton: false,
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: DoctorServiceButton(
                  onTap: () {},
                  text: "Delete",
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

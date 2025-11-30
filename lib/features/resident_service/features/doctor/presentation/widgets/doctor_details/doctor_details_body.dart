import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/widgets/readmore_text.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/custom_doc_reviws_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_circle_with_data_list.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_details_card_widget.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/custom_text_identfier_widget.dart';

class DoctorDetailsBody extends StatelessWidget {
  const DoctorDetailsBody({super.key, required this.doctor});
  final DoctorDataModel doctor;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
      children: [
        CustomDoctorDatailsCardWeiget(doctor: doctor),
        const SizedBox(height: 18),
        CustomCircleWithDataList(doctor: doctor),
        const SizedBox(height: 20),
        Text(
          "aboutMe".tr(context),
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: 10),
        ReadmoreText(maxLines: 3, text: doctor.description),
        const SizedBox(height: 20),
        TextDetailsIdentfierWidget(
          leading: "workingSchedule".tr(context),
          trailing: "seeServices".tr(context),
          onTap: () {
            context.read<DoctorCubit>().doctorId = doctor.id;
            context.pushScreen(
              AppRoutes.doctorSeeSevicesScreen,
              arguments: doctor.id,
            );
          },
        ),

        const SizedBox(height: 15),
        TextDetailsIdentfierWidget(
          leading: "reviwes".tr(context),
          trailing: "seeAll".tr(context),
          onTap: () {
            context.pushScreen(AppRoutes.doctorReviewScreen);
          },
        ),
        const SizedBox(height: 20),
        DoctorReviewsList(length: 3, shrinkWrap: true),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/custom_more_app_bar_widget.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/doctor_details_body.dart';

class DoctorDetailsView extends StatelessWidget {
  const DoctorDetailsView({super.key, required this.doctor});
  final DoctorDataModel doctor;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          "${"dr".tr(context)} ${doctor.fullName}",
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700),
        ),
        forceMaterialTransparency: true,
        actions: [CustomMoreAppBarWidget()],
      ),
      body: DoctorDetailsBody(doctor: doctor),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/add_service_view_body.dart';

class EditDoctorServiceView extends StatelessWidget {
  const EditDoctorServiceView({super.key, required this.doctorServiceModel});
  final DoctorServiceModel doctorServiceModel;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("editService".tr(context)),
        forceMaterialTransparency: true,
      ),
      body: AddServiceViewBody(doctorServiceModel: doctorServiceModel),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/add_service_view_body.dart';

class DoctorAddServiceView extends StatelessWidget {
  const DoctorAddServiceView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("addNewService".tr(context)),
        forceMaterialTransparency: true,
      ),
      body: const AddServiceViewBody(),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/add_service_view_body.dart';

class EditDoctorServiceView extends StatefulWidget {
  const EditDoctorServiceView({super.key, required this.doctorServiceModel});
  final DoctorServiceModel doctorServiceModel;

  @override
  State<EditDoctorServiceView> createState() => _EditDoctorServiceViewState();
}

class _EditDoctorServiceViewState extends State<EditDoctorServiceView> {
  @override
  void initState() {
    resetState();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("editService".tr(context)),
        forceMaterialTransparency: true,
      ),
      body: AddServiceViewBody(doctorServiceModel: widget.doctorServiceModel),
    );
  }

  void resetState() {
    context.read<DoctorServiceMangementCubit>().resetState();
  }
}

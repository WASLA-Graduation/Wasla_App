import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/add_service_view_body.dart';

class DoctorAddServiceView extends StatefulWidget {
  const DoctorAddServiceView({super.key});

  @override
  State<DoctorAddServiceView> createState() => _DoctorAddServiceViewState();
}

class _DoctorAddServiceViewState extends State<DoctorAddServiceView> {
  @override
  void initState() {
    resetState();
    super.initState();
  }

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

  void resetState() {
    context.read<DoctorServiceMangementCubit>().resetState();
  }
}

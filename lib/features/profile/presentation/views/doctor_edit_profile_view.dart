import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/profile/presentation/widgets/doctor/doc_edit_profile_body.dart';

class DoctorEditProfileView extends StatefulWidget {
  const DoctorEditProfileView({super.key, required this.doctor});
  final DoctorModel doctor;

  @override
  State<DoctorEditProfileView> createState() => _DoctorEditProfileViewState();
}

class _DoctorEditProfileViewState extends State<DoctorEditProfileView> {
  @override
  void initState() {
    getDoctorSpecialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text('editProfile'.tr(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
        child: DocEditProfileBody(doctor: widget.doctor),
      ),
    );
  }

  void getDoctorSpecialization() async =>
      context.read<ProfileCubit>().getDoctorSpecialization();
}

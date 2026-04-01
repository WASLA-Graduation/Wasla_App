import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/doctor_info_body.dart';

class DoctorInfoView extends StatefulWidget {
  const DoctorInfoView({super.key});

  @override
  State<DoctorInfoView> createState() => _DoctorInfoViewState();
}

class _DoctorInfoViewState extends State<DoctorInfoView> {
  @override
  void initState() {
    getDoctorSpecialization();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,

        title: Text("fillYourProfile".tr(context)),
      ),
      body: DoctorInfoBody(),
    );
  }

  void getDoctorSpecialization() async =>
      context.read<AuthCubit>().getDoctorSpecialization();
}

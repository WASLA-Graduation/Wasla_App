import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/widgets/service_view_body.dart';

class ServiceView extends StatefulWidget {
  const ServiceView({super.key});

  @override
  State<ServiceView> createState() => _ServiceViewState();
}

class _ServiceViewState extends State<ServiceView> {
  @override
  void initState() {
    getDoctorSevices();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ServiceViewBody();
  }

  void getDoctorSevices() async {
    context.read<DoctorServiceMangementCubit>().getDoctorServices();
  }
}

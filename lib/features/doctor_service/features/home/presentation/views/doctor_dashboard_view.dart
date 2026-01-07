import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/doc_home/doctor_dashboard_body.dart';

class DoctorDashboardView extends StatefulWidget {
  const DoctorDashboardView({super.key});

  @override
  State<DoctorDashboardView> createState() => _DoctorDashboardViewState();
}

class _DoctorDashboardViewState extends State<DoctorDashboardView> {
  @override
  void initState() {
    getDoctorChartAndBookings();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
        child: DoctorDashboardBody(),
      ),
    );
  }

  void getDoctorChartAndBookings() async {
    context.read<DoctorHomeCubit>().getDoctorChart();
    context.read<DoctorHomeCubit>().bookingStatus = 1;
    context.read<DoctorHomeCubit>().getDoctorBookings(status: 1);
    context.read<DoctorHomeCubit>().getUserProfile();
  }
}

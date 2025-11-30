import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/custom_more_app_bar_widget.dart';
import 'package:wasla/features/doctor_service/features/service/data/models/doctor_service_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/doctor_booking_view_body.dart';

class DoctorBookingView extends StatefulWidget {
  const DoctorBookingView({super.key, required this.doctorServiceModel});
  final DoctorServiceModel doctorServiceModel;

  @override
  State<DoctorBookingView> createState() => _DoctorBookingViewState();
}

class _DoctorBookingViewState extends State<DoctorBookingView> {
  @override
  void initState() {
    callFristDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Booking Service"),
        actions: [CustomMoreAppBarWidget()],
      ),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: DoctorBookingViewBody(
          doctorServiceModel: widget.doctorServiceModel,
        ),
      ),
    );
  }

  void callFristDay() {
    context.read<DoctorCubit>().dayListTimeSlots = [];
    context.read<DoctorCubit>().timeCurrentIndex = -1;
    context.read<DoctorCubit>().dayCurrentIndex = 0;
    context.read<DoctorCubit>().dayOfWeek =
        widget.doctorServiceModel.serviceDays[0].dayOfWeek;
    context.read<DoctorCubit>().addDayTimeSlotToList(
      serviceDay: widget.doctorServiceModel.serviceDays[0],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/service/signalR/doctor_booking_hub.dart';
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
  final signalR = BookingSignalRService();

  @override
  void initState() {
    callFristDay();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("bookingService".tr(context))),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: DoctorBookingViewBody(
          doctorServiceModel: widget.doctorServiceModel,
        ),
      ),
    );
  }

  void callFristDay() {
    signalR.connect(context).then((_) {
      signalR.listen(context);
    });
    context.read<DoctorCubit>().resetState();
    context.read<DoctorCubit>().dayOfWeek =
        widget.doctorServiceModel.serviceDays[0].dayOfWeek;
    context.read<DoctorCubit>().addDayTimeSlotToList(
      serviceDay: widget.doctorServiceModel.serviceDays[0],
    );
  }
}

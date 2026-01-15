import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
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
  void dispose() {
    signalR.disconnect();
    super.dispose();
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
    final cubit = context.read<DoctorCubit>();
    signalR.connect(context).then((_) {
      signalR.listen(context);
    });
    cubit.resetState();
    cubit.dayOfWeek = widget.doctorServiceModel.serviceDays[0].dayOfWeek;
    cubit.addDayTimeSlotToList(
      serviceDay: widget.doctorServiceModel.serviceDays[0],
    );
    cubit.signalRSevice.currentRoute = AppRoutes.doctorBookingScreen;
    cubit.currentServiceId=widget.doctorServiceModel.id;
  }
}

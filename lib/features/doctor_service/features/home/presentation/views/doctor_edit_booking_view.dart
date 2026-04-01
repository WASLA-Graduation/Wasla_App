import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/format_time_with_intl.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_booking_model.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/manager/cubit/doctor_home_cubit.dart';
import 'package:wasla/features/doctor_service/features/home/presentation/widgets/booking/doc_edit_body.dart';

class DoctorEditBookingView extends StatefulWidget {
  const DoctorEditBookingView({super.key, required this.bookingModel});
  final DoctorBookingModel bookingModel;

  @override
  State<DoctorEditBookingView> createState() => _DoctorEditBookingViewState();
}

class _DoctorEditBookingViewState extends State<DoctorEditBookingView> {
  @override
  void initState() {
    inintializeTime();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("editBooking".tr(context))),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: DocEditBookingBody(bookingModel: widget.bookingModel),
      ),
    );
  }

  void inintializeTime() {
    context.read<DoctorHomeCubit>().currentChoosenDate =
        convertStringToDateTime(widget.bookingModel.date);
    context.read<DoctorHomeCubit>().currentChoosenFromTime =
        convertStringToTimeOfDay(widget.bookingModel.start);
    context.read<DoctorHomeCubit>().currentChoosenToTime =
        convertStringToTimeOfDay(widget.bookingModel.end);
  }
}

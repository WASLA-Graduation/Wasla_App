import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/doctor/data/models/doctor_data_model.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_details/doctor_details_body.dart';

class DoctorDetailsView extends StatefulWidget {
  const DoctorDetailsView({super.key, required this.doctor});
  final DoctorDataModel doctor;

  @override
  State<DoctorDetailsView> createState() => _DoctorDetailsViewState();
}

class _DoctorDetailsViewState extends State<DoctorDetailsView> {
  @override
  void initState() {
    getDoctorReveiws();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          widget.doctor.fullName,
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontWeight: FontWeight.w700),
        ),
        forceMaterialTransparency: true,
      ),
      body: DoctorDetailsBody(doctor: widget.doctor),
    );
  }

  void getDoctorReveiws() async {
    context.read<DoctorCubit>().resetState();
    context.read<DoctorCubit>().getDoctorReveiws(widget.doctor.id);
    context.read<DoctorCubit>().doctorId = widget.doctor.id;
  }
}

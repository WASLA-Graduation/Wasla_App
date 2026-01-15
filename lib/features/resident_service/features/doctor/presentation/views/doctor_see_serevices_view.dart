import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/all_services/see_all_services_body.dart';

class DoctorSeeSerevicesView extends StatefulWidget {
  const DoctorSeeSerevicesView({super.key, required this.docId});

  final String docId;

  @override
  State<DoctorSeeSerevicesView> createState() => _DoctorSeeSerevicesViewState();
}

class _DoctorSeeSerevicesViewState extends State<DoctorSeeSerevicesView> {
  @override
  void initState() {
    super.initState();
    getDoctorSevices();
    enableSignalR();
  }

  @override
  void dispose() {
    // context.read()<DoctorCubit>().signalRSevice.disconnect();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("services".tr(context))),

      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
        child: DoctorSeeSerevicesViewBody(),
      ),
    );
  }

  void getDoctorSevices() async {
    context.read<DoctorCubit>().getDoctorServices(doctorId: widget.docId);
  }

  void enableSignalR() async {
    context.read<DoctorCubit>().signalRSevice.connect().then((_) {
      context.read<DoctorCubit>().signalRSevice.listen(context);
      context.read<DoctorCubit>().signalRSevice.currentRoute =
          AppRoutes.doctorSeeSevicesScreen;
    });
  }
}

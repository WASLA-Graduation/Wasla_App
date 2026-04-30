import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/manager/cubit/doctor_cubit.dart';
import 'package:wasla/features/resident_service/features/doctor/presentation/widgets/doctor_view_body.dart';

class DoctorView extends StatefulWidget {
  const DoctorView({super.key});

  @override
  State<DoctorView> createState() => _DoctorViewState();
}

class _DoctorViewState extends State<DoctorView> {
  @override
  void initState() {
    getDoctorSpeciality();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("doctors".tr(context))),

      body: BlocStatusHandler<DoctorCubit, DoctorState>(
        body: const DoctorViewBody(),
        onRetry: () {
          context.read<DoctorCubit>().onRetry();
          getDoctorSpeciality();
        },
        isNetwork: (state) => state is DoctorNetworkState,
        isError: (state) => state is DoctorFailureState,
        buildWhen: (previous, current) =>
            current is DoctorNetworkState ||
            current is DoctorFailureState ||
            current is DoctorOnRetryState,
      ),
    );
  }

  void getDoctorSpeciality() async {
    await context.read<DoctorCubit>().getDoctorSpecialization();
    await context.read<DoctorCubit>().getDoctorsBySpecialization(
      specializationId: 0,
    );
    await context.read<FavouriteCubit>().getFavouritesByType(serviceType: 1);
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/widgets/gym_resident_see_packages_body.dart';

class ResidentGymSeePakcagesView extends StatefulWidget {
  const ResidentGymSeePakcagesView({super.key, required this.gymId});
  final String gymId;

  @override
  State<ResidentGymSeePakcagesView> createState() =>
      _ResidentGymSeePakcagesViewState();
}

class _ResidentGymSeePakcagesViewState
    extends State<ResidentGymSeePakcagesView> {
  @override
  void initState() {
    getPackages();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("packages".tr(context)),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 30, 16, 0),
        child: const ResidentGymSeePakcagesViewBody(),
      ),
    );
  }

  void getPackages() {
    context.read<GymResidentCubit>().getGymPackages(gymId: widget.gymId);
  }
}

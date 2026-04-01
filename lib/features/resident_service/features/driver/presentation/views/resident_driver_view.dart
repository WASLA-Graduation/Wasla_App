import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/resident_driver_body.dart';

class ResidentDriverView extends StatefulWidget {
  const ResidentDriverView({super.key});

  @override
  State<ResidentDriverView> createState() => _ResidentDriverViewState();
}

class _ResidentDriverViewState extends State<ResidentDriverView> {
  @override
  void initState() {
    getMyLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   forceMaterialTransparency: true,
      //   title: Text("drivers".tr(context)),
      // ),
      body: const ResidentDriverBody(),
    );
  }

  void getMyLocation() {
    context.read<ResidentDriverCubit>().getMyLocation();
  }
}

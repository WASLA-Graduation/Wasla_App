import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/driver_enums.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/driver_info_body.dart';

class DriverInfoView extends StatefulWidget {
  const DriverInfoView({super.key});

  @override
  State<DriverInfoView> createState() => _DriverInfoViewState();
}

class _DriverInfoViewState extends State<DriverInfoView> {
  @override
  void initState() {
    reset();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("completYourProfile".tr(context)),
      ),
      body: Padding(padding: const EdgeInsets.all(20), child: DriverInfoBody()),
    );
  }

  void reset() => context.read<AuthCubit>().vehicleType = VehicleType.car;
}

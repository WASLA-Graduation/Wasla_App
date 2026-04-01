import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/enter_location_body.dart';

class EnterYourLocatoinView extends StatefulWidget {
  const EnterYourLocatoinView({super.key});

  @override
  State<EnterYourLocatoinView> createState() => _EnterYourLocatoinViewState();
}

class _EnterYourLocatoinViewState extends State<EnterYourLocatoinView> {
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
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            context.popScreen();
          },
          icon: Icon(
            Icons.close,
            color: context.isDarkMode ? Colors.white : Colors.black,
            size: 23,
          ),
        ),
        title: Text("letsTravel".tr(context)),
      ),

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: const EnterLocationBody(),
        ),
      ),
    );
  }

  void reset() {
    context.read<ResidentDriverCubit>().reset();
  }
}

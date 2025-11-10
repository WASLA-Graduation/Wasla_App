import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/service/maps/cubit/maps_helper_cubit.dart';
import 'package:wasla/core/responsive/size_config.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';

class SaveCurrentLocationWidget extends StatelessWidget {
  const SaveCurrentLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();
    final cubit = context.read<MapsHelperCubit>();
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        margin: EdgeInsets.all(20),
        width: SizeConfig.blockWidth * 50,
        child: GeneralButton(
          onPressed: () async {
            await cubit.getAddressFromLatLng(cubit.lat, cubit.long).then((
              value,
            ) {
              authCubit.addressController.text = cubit.locationAddress;
              authCubit.lat = cubit.lat.toString();
              authCubit.lan = cubit.long.toString();
              context.popScreen();
            });
          },
          text: "Save",
          height: 60,
        ),
      ),
    );
  }
}

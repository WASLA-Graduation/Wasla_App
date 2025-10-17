import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/service/maps/cubit/maps_helper_cubit.dart';
import 'package:wasla/core/utils/app_colors.dart';

class CurrentLocationWidget extends StatelessWidget {
  const CurrentLocationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapsHelperCubit>();
    return Align(
      alignment: Alignment.bottomRight,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: CircleAvatar(
          radius: 30,
          backgroundColor: AppColors.primaryColor,
          child: IconButton(
            onPressed: () {
              cubit.backToOriginalLocation();
            },
            icon: Icon(Icons.location_on, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/service/maps/cubit/maps_helper_cubit.dart';
import 'package:wasla/core/utils/app_colors.dart';

class ControlMapZoomWidget extends StatelessWidget {
  const ControlMapZoomWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<MapsHelperCubit>();

    return Align(
      alignment: Alignment.bottomLeft,
      child: Container(
        margin: EdgeInsets.all(20),
        padding: EdgeInsets.symmetric(vertical: 15),
        width: 40,
        height: 100,
        color: AppColors.primaryColor,
        child: Column(
          children: [
            InkWell(
              onTap: () => cubit.updateMapZoomIn(),

              child: Icon(Icons.add, size: 25, color: Colors.white),
            ),
            Divider(color: Colors.white),
            InkWell(
              onTap: () => cubit.updateMapZoomOut(),
              child: Icon(Icons.remove, size: 25, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}

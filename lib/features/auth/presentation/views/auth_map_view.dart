import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/service/maps/cubit/maps_helper_cubit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_auth_map_widget.dart';

class AuthMapView extends StatelessWidget {
  const AuthMapView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocBuilder<MapsHelperCubit, MapsHelperState>(
        builder: (context, state) {
          final cubit = context.read<MapsHelperCubit>();
          switch (state) {
            case MapsHelperGetLocationLoading():
              return Center(
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              );
            case MapsHelperGetLocationError():
              return Center(child: Text(state.message));
            default:
              return CustomAuthMapWidget(cubit: cubit);
          }
        },
      ),
    );
  }
}

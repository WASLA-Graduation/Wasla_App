
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/widgets/custom_home_app_bar.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';
import 'package:wasla/features/technicant/features/home/presentation/manager/cubit/technicant_dashboard_cubit.dart';

class TechnicianDahsboardAppBar extends StatefulWidget {
  const TechnicianDahsboardAppBar({super.key});

  @override
  State<TechnicianDahsboardAppBar> createState() =>
      _TechnicianDahsboardAppBarState();
}

class _TechnicianDahsboardAppBarState extends State<TechnicianDahsboardAppBar> {
  TechnicianModel? technician;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TechnicantDashboardCubit, TechnicantDashboardState>(
      buildWhen: (prev, current) => current is TechnicianGetProfile,
      builder: (context, state) {
        if (state is TechnicianGetProfile) {
          technician = state.technician;
        }
        return CustomHomeAppBar(
          isLoading: technician == null,
          userName: technician?.fullName,
          imageUrl: technician?.profilePhotoUrl,
          onBookmarkTap: () {},
          showBookmark: false,
        );
      },
    );
  }
}

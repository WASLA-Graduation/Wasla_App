import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/manager/cubit/resident_technician_cubit.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/widgets/resident_tech_details_widget.dart';
import 'package:wasla/features/technicant/features/home/data/models/technician_model.dart';

class ResidentTechnicianDetailsBody extends StatefulWidget {
  const ResidentTechnicianDetailsBody({super.key, required this.techId});

  final String techId;

  @override
  State<ResidentTechnicianDetailsBody> createState() =>
      _ResidentTechnicianDetailsBodyState();
}

class _ResidentTechnicianDetailsBodyState
    extends State<ResidentTechnicianDetailsBody> {
  TechnicianModel? technician;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentTechnicianCubit, ResidentTechnicianState>(
      buildWhen: (previous, current) =>
          current is ResidentGetTechnicianDetailsLoading ||
          current is ResidentGetTechnicianDetailsLoaded,
      builder: (context, state) {
        if (state is ResidentGetTechnicianDetailsLoading ||
            state is ResidentTechnicianInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is ResidentGetTechnicianDetailsLoaded) {
          technician = state.technician;
        }

        return ResidentTechnacalDetailsWidget(
          technician: technician!,
          techId: widget.techId,
        );
      },
    );
  }
}

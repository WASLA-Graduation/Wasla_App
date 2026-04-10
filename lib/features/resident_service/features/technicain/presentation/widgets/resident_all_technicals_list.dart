import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/empty_data_widget.dart';
import 'package:wasla/features/resident_service/features/technicain/data/models/resident_technician_model.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/manager/cubit/resident_technician_cubit.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/widgets/resident_tech_pagination_list.dart';

class ResidentAllTechinicalsList extends StatefulWidget {
  const ResidentAllTechinicalsList({super.key});

  @override
  State<ResidentAllTechinicalsList> createState() =>
      _ResidentAllTechinicalsListState();
}

class _ResidentAllTechinicalsListState
    extends State<ResidentAllTechinicalsList> {
  List<ResidentTechnicianModel> technicals = [];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentTechnicianCubit, ResidentTechnicianState>(
      buildWhen: (previous, current) =>
          current is ResidentGetTechniciansSpecializationsLoading ||
          current is ResidentGetTechniciansSpecializationsLoaded,
      builder: (context, state) {
        if (state is ResidentGetTechniciansSpecializationsLoading ||
            state is ResidentTechnicianInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        } else if (state is ResidentGetTechniciansSpecializationsLoaded) {
          technicals = state.technicals;
        }

        return technicals.isEmpty
            ? EmptyStateWidget(
                message: 'noTechnicalsInSystem'.tr(context),
                title: 'noTechnicals'.tr(context),
              )
            : ResidentAllTechinicalsPaginationList(technicals: technicals);
      },
    );
  }
}

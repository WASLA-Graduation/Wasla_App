import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/favourite/presentation/manager/cubit/favourite_cubit.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/manager/cubit/resident_technician_cubit.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/widgets/resident_technician_body.dart';

class ResidentTechnicianView extends StatefulWidget {
  const ResidentTechnicianView({super.key});

  @override
  State<ResidentTechnicianView> createState() => _ResidentTechnicianViewState();
}

class _ResidentTechnicianViewState extends State<ResidentTechnicianView> {
  @override
  void initState() {
    getScreenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        title: Text('allTechnicains'.tr(context)),
      ),

      body: SafeArea(
        child:
            BlocStatusHandler<ResidentTechnicianCubit, ResidentTechnicianState>(
              body: ResidentTechnicianBody(),
              onRetry: () {
                getScreenData();
                context.read<ResidentTechnicianCubit>().whenRetry();
              },
              isNetwork: (state) => state is ResidentTechnicianNetwork,
              isError: (state) => state is ResidentTechnicianFailure,
              buildWhen: (previous, current) =>
                  current is ResidentTechnicianNetwork ||
                  current is ResidentTechnicianFailure ||
                  current is ResidentTechnicianOnRetry,
            ),
      ),
    );
  }

  void getScreenData() {
    final cubit = context.read<ResidentTechnicianCubit>();
    cubit.getTechnicianSpecializations();
    context.read<FavouriteCubit>().getFavouritesByType(serviceType: 5);
    cubit.getTechniciansBySpeciality(fromPagination: false);
  }
}

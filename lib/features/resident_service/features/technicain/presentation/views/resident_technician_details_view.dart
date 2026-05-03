import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/enums/event_type.dart';
import 'package:wasla/core/utils/app_strings.dart';
import 'package:wasla/core/widgets/error_widget.dart';
import 'package:wasla/core/widgets/internet/no_internet_widget.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/manager/cubit/resident_technician_cubit.dart';
import 'package:wasla/features/resident_service/features/technicain/presentation/widgets/resident_technacal_details_body.dart';
import 'package:wasla/features/reviews/presentation/manager/cubit/reviews_cubit.dart';

class ResidentTechnicianDetailsView extends StatefulWidget {
  const ResidentTechnicianDetailsView({super.key, required this.data});

  final Map<String, dynamic> data;

  @override
  State<ResidentTechnicianDetailsView> createState() =>
      _ResidentTechnicianDetailsViewState();
}

class _ResidentTechnicianDetailsViewState
    extends State<ResidentTechnicianDetailsView> {
  @override
  void initState() {
    getScreenData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.data[AppStrings.name]),
        scrolledUnderElevation: 0,
      ),
      body: SafeArea(
        child: BlocBuilder<ResidentTechnicianCubit, ResidentTechnicianState>(
          buildWhen: (previous, current) =>
              current is ResidentTechnicianNetwork ||
              current is ResidentTechnicianFailure ||
              current is ResidentTechnicianOnRetry,
          builder: (context, state) {
            if (state is ResidentTechnicianNetwork) {
              return NoInternetWidget(
                onRetry: () {
                  getScreenData();
                  context.read<ResidentTechnicianCubit>().whenRetry();
                },
              );
            } else if (state is ResidentTechnicianFailure) {
              return MyErrorWidget(
                onRetry: () {
                  getScreenData();
                  context.read<ResidentTechnicianCubit>().whenRetry();
                },
              );
            }
            return ResidentTechnicianDetailsBody(
              techId: widget.data[AppStrings.id],
            );
          },
        ),
      ),
    );
  }

  void getScreenData() {
    final cubit = context.read<ResidentTechnicianCubit>();
    final review = context.read<ReviewsCubit>();
    cubit.getTechnicianDetails(technicianId: widget.data[AppStrings.id]);
    review.resetState();
    review.getReveiws(widget.data[AppStrings.id]);
    review.selectedUserId = widget.data[AppStrings.id];
    context.read<HomeResidentCubit>().createUserEvent(
      serviceProviderId: widget.data[AppStrings.id],
      eventType: EventType.viewDetails,
    );
  }
}

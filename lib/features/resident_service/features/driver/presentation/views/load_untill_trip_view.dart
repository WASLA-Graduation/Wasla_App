import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/service/signalR/driver_hub.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/laod_accept_untill_driver/cancel_request_button.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/laod_accept_untill_driver/search_header_card.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/laod_accept_untill_driver/trip_info_card.dart';

class LoadUntillTripView extends StatefulWidget {
  const LoadUntillTripView({super.key});

  @override
  State<LoadUntillTripView> createState() => _LoadUntillTripViewState();
}

class _LoadUntillTripViewState extends State<LoadUntillTripView> {
  final DriverHub driverHub = DriverHub();
  @override
  void initState() {
    super.initState();
    connectToHub();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF7F8FA),
      body: Column(
        children: [
          const SearchHeaderCard(),
          const SizedBox(height: 25),
          const TripInfoCard(),
          const Spacer(),
          CancelDriverButton(
            title: "cancelRequest".tr(context),
            isSearchingRouete: true,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  void connectToHub() {
    driverHub.init();
    context.read<ResidentDriverCubit>().isDriverArrived = false;
  }
}

class CancelDriverButton extends StatelessWidget {
  const CancelDriverButton({
    super.key,
    required this.title,
    required this.isSearchingRouete,
  });
  final String title;
  final bool isSearchingRouete;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ResidentDriverCubit, ResidentDriverState>(
      buildWhen: (previous, current) =>
          current is ResidentDriverCancelRideLoading ||
          current is ResidentDriverCancelRideSuccess ||
          current is ResidentDriverCancelRideFailure,
      listener: (context, state) {
        if (state is ResidentDriverCancelRideSuccess) {
          toastAlert(
            color: AppColors.primaryColor,
            msg: 'tripCancelled'.tr(context),
          );

          if (isSearchingRouete) {
            context.pop();
          } else {
            context.pop();
            context.pop();
          }
        }
        if (state is ResidentDriverCancelRideFailure) {
          toastAlert(color: AppColors.error, msg: state.errorMessage);
        }
      },
      builder: (context, state) {
        return CancelRequestButton(
          title: state is ResidentDriverCancelRideLoading
              ? 'loading'.tr(context)
              : title,
          onTap: () {
            // context.pushScreen(
            //   AppRoutes.driverTripDetailsScreen,
            //   arguments: 10,
            // );

            context.read<ResidentDriverCubit>().cancelRide();
          },
        );
      },
    );
  }
}

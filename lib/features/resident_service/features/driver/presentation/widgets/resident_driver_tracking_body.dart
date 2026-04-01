import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/driver_arived_bottom_sheet.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/resident_driver_tracking_map.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/trip_details/driver_card_info_source_dest.dart';

class ResidentDriverTrackingBody extends StatelessWidget {
  const ResidentDriverTrackingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final trip = context.read<ResidentDriverCubit>().tripModel!;
    return Stack(
      children: [
        ResidentDriverTrackingMap(),
        Align(
          alignment: Alignment.topCenter,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: context.isDarkMode ? Colors.black : Colors.white,
                borderRadius: BorderRadius.circular(7),
              ),
              child: DriverCardInfoSourceDest(
                destination: trip.dropOffPlace,
                source: trip.pickUpPlace,
                destinationDate: trip.endRide,
                sourceDate: trip.startRide,
              ),
            ),
          ),
        ),

        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: CircleAvatar(
              radius: 30,
              backgroundColor: context.isDarkMode ? Colors.black : Colors.white,
              child: IconButton(
                onPressed: () {
                  context.read<ResidentDriverCubit>().backToOriginalLocation();
                },
                icon: Icon(
                  Icons.my_location,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),

        BlocListener<ResidentDriverCubit, ResidentDriverState>(
          listenWhen: (previous, current) =>
              current is ResidentDriverArrivedState,
          listener: (context, state) {
            if (state is ResidentDriverArrivedState) {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => DriverArrivedBottomSheet(),
              );
            }
          },
          child: const SizedBox(),
        ),
      ],
    );
  }
}

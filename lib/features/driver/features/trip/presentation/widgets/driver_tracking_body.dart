import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/features/driver/features/trip/presentation/manager/cubit/driver_trip_cubit.dart';
import 'package:wasla/features/driver/features/trip/presentation/widgets/driver_arrived_bottom_sheet.dart';
import 'package:wasla/features/driver/features/trip/presentation/widgets/driver_tracking_map.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/trip_details/driver_card_info_source_dest.dart';

class DriverTrackingBody extends StatelessWidget {
  const DriverTrackingBody({super.key});

  @override
  Widget build(BuildContext context) {
    final tripDetails = context.read<DriverTripCubit>().tripDetails;
    return Stack(
      children: [
        DriverTrackingMap(),
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
                destination: tripDetails!.dropOffPlace,
                destinationDate: tripDetails.dropOffTime,
                source: tripDetails.pickUpPlace,
                sourceDate: tripDetails.pickUpTime,
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
                  context.read<DriverTripCubit>().backToOriginalLocation();
                },
                icon: Icon(
                  Icons.my_location,
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
              ),
            ),
          ),
        ),

        BlocListener<DriverTripCubit, DriverTripState>(
          listenWhen: (previous, current) => current is DriverWhenArrived,
          listener: (context, state) {
            if (state is DriverWhenArrived) {
              showModalBottomSheet(
                context: context,
                backgroundColor: Colors.transparent,
                isScrollControlled: true,
                builder: (_) => DriverArrivedToPassengerBottomSheet(),
              );
            }
          },
          child: const SizedBox(),
        ),
      ],
    );
  }
}

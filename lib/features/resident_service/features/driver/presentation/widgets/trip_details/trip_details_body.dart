import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/views/load_untill_trip_view.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/trip_details/driver_info_card.dart';

class DriverTripDetailsViewBody extends StatelessWidget {
  const DriverTripDetailsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(child: DriverInfoCard()),
        BlocBuilder<ResidentDriverCubit, ResidentDriverState>(
          buildWhen: (previous, current) =>
              current is ResidentDriverArrivedState,

          builder: (context, state) {
            return context.read<ResidentDriverCubit>().isDriverArrived
                ? GeneralButton(
                    onPressed: () {
                      context.pushAndRemoveAllScreens(
                        AppRoutes.residenBottomNavBar,
                      );
                    },
                    text: 'backToHome'.tr(context),
                  )
                : CancelDriverButton(
                    title: 'cancelTrip'.tr(context),
                    isSearchingRouete: false,
                  );
          },
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}

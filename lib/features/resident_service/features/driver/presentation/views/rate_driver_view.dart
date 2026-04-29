import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/widgets/bloc_status_handler.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/widgets/rate_driver_body.dart';

class DriverReviewScreen extends StatefulWidget {
  const DriverReviewScreen({super.key, required this.driverId});
  final String driverId;

  @override
  State<DriverReviewScreen> createState() => _DriverReviewScreenState();
}

class _DriverReviewScreenState extends State<DriverReviewScreen> {
  @override
  void initState() {
    getDriverProfile();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: Text("rateDriver".tr(context)),
        leading: GestureDetector(
          onTap: () {
            if (context.canPop()) {
              context.popScreen();
            } else {
              context.pushAndRemoveAllScreens(AppRoutes.residenBottomNavBar);
            }
          },
          child: Icon(
            Icons.close,
            size: 24,
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
      ),
      body: SafeArea(
        child: BlocStatusHandler<ResidentDriverCubit, ResidentDriverState>(
          body: RateDriverBody(driverId: widget.driverId),
          onRetry: () {
            getDriverProfile();
            context.read<ResidentDriverCubit>().onRetry();
          },
          isNetwork: (state) => state is ResidentDriverNetworkState,
          isError: (state) => state is ResidentDriverFailureState,
          buildWhen: (previous, current) =>
              current is ResidentDriverNetworkState ||
              current is ResidentDriverFailureState ||
              current is ResidentDriverOnRetryState,
        ),
      ),
    );
  }

  void getDriverProfile() {
    context.read<ResidentDriverCubit>().getDriverProfile(
      driverId: widget.driverId,
    );
  }
}

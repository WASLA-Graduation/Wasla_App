import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_sizes.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/driver/features/home/data/models/driver_profile_model.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';

class RateDriverBody extends StatefulWidget {
  const RateDriverBody({super.key, required this.driverId});
  final String driverId;

  @override
  State<RateDriverBody> createState() => _RateDriverBodyState();
}

class _RateDriverBodyState extends State<RateDriverBody> {
  DriverProfileModel? driver;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentDriverCubit, ResidentDriverState>(
      buildWhen: (previous, current) => current is ResidentDriverProfileSuccess,
      builder: (context, state) {
        if (state is ResidentDriverProfileSuccess) {
          driver = state.driver;
        } else if (state is ResidentDriverProfileLoading ||
            state is ResidentDriverInitial) {
          return Center(
            child: SpinKitFadingCircle(
              color: AppColors.primaryColor,
              size: 50.0,
            ),
          );
        }
        return RateDriverBodyContent(
          driver: driver!,
          driverId: widget.driverId,
        );
      },
    );
  }
}

class RateDriverBodyContent extends StatelessWidget {
  const RateDriverBodyContent({
    super.key,
    required this.driver,
    required this.driverId,
  });

  final DriverProfileModel driver;
  final String driverId;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: AppSizes.marginDefault),
      child: PopScope(
        canPop: false,
        onPopInvokedWithResult: (didPop, result) {
          if (didPop) {
            return;
          } else {
            if (context.canPop()) {
              context.popScreen();
            } else {
              context.pushAndRemoveAllScreens(AppRoutes.residenBottomNavBar);
            }
          }
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),

            Center(
              child: CircleNeworkImage(
                imageUrl: driver.imageUrlBase,
                isLoading: false,
                size: 120,
              ),
            ),
            const SizedBox(height: 20),

            Center(
              child: Text(
                'howWasDriver'.tr(context),
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
            const SizedBox(height: 6),
            Center(
              child: Text(
                'rateTrip'.tr(context),
                style: Theme.of(context).textTheme.labelSmall,
              ),
            ),
            const SizedBox(height: 24),

            DriverStarsReview(),
            const SizedBox(height: 32),
            const Spacer(),
            BlocConsumer<ResidentDriverCubit, ResidentDriverState>(
              buildWhen: (previous, current) =>
                  current is ResidentAddRatingLoading ||
                  current is ResidentAddRatingSuccess ||
                  current is ResidentAddRatingFailure,
              listener: (context, state) {
                if (state is ResidentAddRatingSuccess) {
                  if (context.canPop()) {
                    context.popScreen();
                  } else {
                    context.pushAndRemoveAllScreens(
                      AppRoutes.residenBottomNavBar,
                    );
                  }
                }
                if (state is ResidentAddRatingFailure) {
                  toastAlert(color: AppColors.error, msg: state.errorMessage);
                }
              },
              builder: (context, state) {
                return GeneralButton(
                  onPressed: () {
                    context.read<ResidentDriverCubit>().addRating(
                      driverId: driverId,
                    );
                  },
                  text: state is ResidentAddRatingLoading
                      ? 'loading'.tr(context)
                      : 'giveRate'.tr(context),
                );
              },
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class DriverStarsReview extends StatelessWidget {
  const DriverStarsReview({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ResidentDriverCubit, ResidentDriverState>(
      buildWhen: (previous, current) =>
          current is ResidentDriverUpdateSelectedStarIndex,
      builder: (context, state) {
        final cubit = context.read<ResidentDriverCubit>();
        return Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(5, (index) {
            return GestureDetector(
              onTap: () => cubit.updateSelectedStartIndex(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6),
                child: Icon(
                  cubit.selecedRouteIndex >= index
                      ? Icons.star
                      : Icons.star_border,
                  size: 36,
                  color: index <= cubit.selecedRouteIndex
                      ? AppColors.primaryColor
                      : Colors.grey[400],
                ),
              ),
            );
          }),
        );
      },
    );
  }
}

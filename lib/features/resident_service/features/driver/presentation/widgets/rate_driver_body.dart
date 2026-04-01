import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_circle_network_image.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/resident_service/features/driver/presentation/manager/cubit/resident_driver_cubit.dart';
import 'package:wasla/features/resident_service/features/home/presentation/manager/cubit/home_resident_cubit.dart';

class RateDriverBody extends StatelessWidget {
  const RateDriverBody({super.key, required this.driverId});
  final String driverId;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 20),

        Center(
          child: CircleNeworkImage(
            imageUrl: context.read<HomeResidentCubit>().user!.imageUrl,
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
              context.pop();
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

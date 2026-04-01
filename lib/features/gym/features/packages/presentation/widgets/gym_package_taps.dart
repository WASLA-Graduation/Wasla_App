import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/custom_resident_booking_taps.dart';

class GymPackageOffersTaps extends StatelessWidget {
  const GymPackageOffersTaps({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymPackagesCubit>();

    return BlocBuilder<GymPackagesCubit, GymPackagesState>(
      builder: (context, state) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(2, (index) {
            return Expanded(
              child: CustomTapWidget(
                isSelected: cubit.tapsCurrentIndex == index,
                title: getTapTitle(index).tr(context),
                onTap: () {
                  cubit.updateCurrentTap(index: index);
                  cubit.getPackagesOrOffersByCurrentTap();
                },
              ),
            );
          }),
        );
      },
    );
  }

  String getTapTitle(int index) {
    switch (index) {
      case 0:
        return "packages";
      case 1:
        return "offers";
      default:
        return "";
    }
  }
}

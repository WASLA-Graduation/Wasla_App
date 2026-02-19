import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/custom_qr_dialog.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/resident_service/features/gym/presentation/manager/cubit/gym_resident_cubit.dart';

class PackageItemContent extends StatelessWidget {
  const PackageItemContent({
    super.key,
    required this.model,
    this.withBookingButton,
  });
  final GymPackageModel model;
  final bool? withBookingButton;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 4,

      crossAxisAlignment: CrossAxisAlignment.start,

      children: [
        Text(
          context.isArabic ? model.nameAr : model.nameEn,
          style: Theme.of(context).textTheme.headlineMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(),
        Text(
          context.isArabic ? model.descriptionAr : model.descriptionEn,
          style: Theme.of(context).textTheme.bodyMedium,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        model.precentage == 0
            ? FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${model.price} ${"egb".tr(context)}",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.primaryColor,
                  ),
                ),
              )
            : Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: "${model.price} ${"egb".tr(context)} ",
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(
                            color: AppColors.primaryColor,
                            decoration: TextDecoration.lineThrough,
                          ),
                    ),
                    TextSpan(
                      text: " ${calculateFinalSalay()} ${"egb".tr(context)} ",
                      style: Theme.of(context).textTheme.headlineSmall!
                          .copyWith(color: AppColors.primaryColor),
                    ),
                  ],
                ),
              ),
        FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            "${model.durationInMonths} ${"months".tr(context)}",
            style: Theme.of(context).textTheme.bodyMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ),

        withBookingButton == true
            ? GymBookingButton(bookingId: model.id)
            : const SizedBox(),
      ],
    );
  }

  String calculateFinalSalay() {
    double finalSalary = model.price - (model.price * (model.precentage / 100));
    return finalSalary.toString();
  }
}

class GymBookingButton extends StatelessWidget {
  const GymBookingButton({super.key, required this.bookingId});
  final int bookingId;
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymResidentCubit>();
    return BlocConsumer<GymResidentCubit, GymResidentState>(
      buildWhen: (previous, current) => bookingId == cubit.serviceIdFlag,
      listener: (context, state) {
        if (state is GymResidentBookingFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is GymResidentBookingSuccess &&
            cubit.serviceIdFlag == bookingId) {
          cubit.serviceIdFlag = -1;
          showDialog(
            context: context,
            builder: (context) {
              return QrCodeDialog(qrCode: state.qrCodeUrl);
            },
          );
        }
      },
      builder: (context, state) {
        return GeneralButton(
          onPressed: () async {
            await cubit.bookAtGym(
              bookingId: bookingId,
              gymId: cubit.selecedGymId,
            );
          },
          fontSize: 12,
          height: 25,
          text: bookingId == cubit.serviceIdFlag
              ? 'loading'.tr(context)
              : 'bookNow'.tr(context),
        );
      },
    );
  }
}

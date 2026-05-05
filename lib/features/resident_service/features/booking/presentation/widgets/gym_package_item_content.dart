import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/enums/payment_method.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/resident_service/features/booking/presentation/widgets/gym_booking_bottom_sheet.dart';
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
          maxLines: 1,
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
            ? GymBookingButton(bookingId: model.id, price: model.price.toInt())
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
  const GymBookingButton({
    super.key,
    required this.bookingId,
    required this.price,
  });
  final int bookingId;
  final int price;
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<GymResidentCubit, GymResidentState>(
      listenWhen: (previous, current) =>
          current is GymResidentBookingState && current.itemId == bookingId,
      buildWhen: (previous, current) =>
          current is GymResidentBookingState && current.itemId == bookingId,
      listener: (context, state) {
        if (state is GymResidentBookingFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is GymResidentBookingSuccessFromCash) {
          toastAlert(
            color: AppColors.primaryColor,
            msg: "bookingDone".tr(context),
          );
          context.popScreen();
        }
      },
      builder: (context, state) {
        return GeneralButton(
          onPressed: () async {
            final cubit = context.read<GymResidentCubit>();
            cubit.paymentMethod = PaymentMethod.wallet;
            showModalBottomSheet(
              context: context,
              builder: (context) => BlocProvider.value(
                value: cubit,
                child: GymBookingBottomSheet(
                  bookingId: bookingId,
                  price: price,
                ),
              ),
            );
          },
          fontSize: 12,
          height: 25,
          text: state is GymResidentBookingLoading
              ? 'loading'.tr(context)
              : 'bookNow'.tr(context),
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/assets.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/doctor_service/features/service/presentation/manager/cubit/doctor_service_mangement_cubit.dart';

class DoctorRemoveServiceDialog extends StatelessWidget {
  const DoctorRemoveServiceDialog({
    super.key,
    required this.serviceNameAR,
    required this.serviceNameEn,
    required this.serviceId,
  });

  final String serviceNameAR;
  final String serviceNameEn;
  final int serviceId;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        padding: const EdgeInsets.all(25),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          spacing: 15,
          children: [
            Image.asset(Assets.assetsImagesDelete, height: 60),
            Text(
              "areYouSure".tr(context),
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "${"douYouWantRelly".tr(context)}${context.isArabic ? "$serviceNameAR؟" : "$serviceNameEn?"}",
                style: Theme.of(
                  context,
                ).textTheme.displaySmall!.copyWith(color: AppColors.gray),
              ),
            ),
            Row(
              children: [
                Expanded(
                  child: GeneralButton(
                    onPressed: () {
                      context.popScreen();
                    },
                    text: 'cancel'.tr(context),
                    color: const Color(0xFFd1d5db),
                    height: 40,
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child:
                      BlocConsumer<
                        DoctorServiceMangementCubit,
                        DoctorServiceMangementState
                      >(
                        listener: (context, state) {
                          if (state
                              is DoctorServiceMangementDelateServiceFailure) {
                            toastAlert(
                              color: AppColors.red,
                              msg: state.errorMessage,
                            );
                          }
                        },
                        builder: (context, state) {
                          return GeneralButton(
                            onPressed: () {
                              context.popScreen();
                              context
                                  .read<DoctorServiceMangementCubit>()
                                  .deletDoctorService(serviceId: serviceId);
                            },
                            text: 'delete'.tr(context),
                            color: AppColors.red,
                            height: 40,
                          );
                        },
                      ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/gym/features/packages/data/models/gym_package_model.dart';
import 'package:wasla/features/gym/features/packages/presentation/manager/cubit/gym_packages_cubit.dart';
import 'package:wasla/features/gym/features/packages/presentation/widgets/gym_add_update_package_form.dart';

class GymAddUpdatePackageViewBody extends StatelessWidget {
  const GymAddUpdatePackageViewBody({super.key, this.package});
  final GymPackageModel? package;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<GymPackagesCubit>();
    return Column(
      children: [
        Expanded(child: GymAddUpdatePackageForm(model: package)),
        const SizedBox(height: 20),
        BlocConsumer<GymPackagesCubit, GymPackagesState>(
          listener: (context, state) {
            if (state is GymAddOrUpdatePackagesAndOffersError) {
              toastAlert(color: AppColors.error, msg: state.errorMessage);
            } else if (state is GymAddOrUpdatePackagesAndOffersSuccess) {
              isEdit()
                  ? toastAlert(
                      color: AppColors.green,
                      msg: "packageUpdatedSuccessfully",
                    )
                  : toastAlert(
                      color: AppColors.primaryColor,
                      msg: "packageAddedSuccessfully".tr(context),
                    );
              Navigator.pop(context);
            }
          },
          builder: (context, state) {
            return GeneralButton(
              onPressed: () async {
                if (cubit.gymAddUpdateFormKey.currentState!.validate()) {
                  cubit.addOrUpdatePackageOrOffer(
                    isAdding: !isEdit(),
                    packageId: package?.id,
                  );
                }
              },
              text: state is GymAddOrUpdatePackagesAndOffersLoading
                  ? "loading".tr(context)
                  : isEdit()
                  ? "updatePackage".tr(context)
                  : 'addPackage'.tr(context),
            );
          },
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  bool isEdit() {
    return package != null;
  }
}

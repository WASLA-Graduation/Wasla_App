import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/doctor_service/features/home/data/models/doctor_model.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';
import 'package:wasla/features/profile/presentation/widgets/doctor/doc_edit_profile_form.dart';

class DocEditProfileBody extends StatelessWidget {
  const DocEditProfileBody({super.key, required this.doctor});
  final DoctorModel doctor;

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return Column(
      children: [
        Expanded(
          child: DoctorEditProfileForm(doctor: doctor, cubit: cubit),
        ),
        const SizedBox(height: 12),
        BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ProfileUpdateInfoFailure) {
              toastAlert(color: AppColors.error, msg: state.errMsg);
            }
            if (state is ProfileUpdateInfoSuccess) {
              toastAlert(
                color: AppColors.green,
                msg: "profile_updated_success".tr(context),
              );
            }
          },
          builder: (context, state) {
            return GeneralButton(
              onPressed: () async {
                await cubit.updateUsertInfo();
              },
              text: state is ProfileUpdateInfoLoading
                  ? "loading".tr(context)
                  : 'save'.tr(context),
            );
          },
        ),
      ],
    );
  }
}

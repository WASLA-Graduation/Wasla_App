import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_lable_add_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/features/profile/presentation/manager/cubit/profile_cubit.dart';

class CustomChangePassForm extends StatelessWidget {
  const CustomChangePassForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();
    return BlocConsumer<ProfileCubit, ProfileState>(
      listener: (context, state) {
        if (state is ProfileChangePassFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is ProfileChangePassSuccess) {
          toastAlert(
            color: AppColors.green,
            msg: "Successfully,Password Changed",
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: cubit.changePassFormKey,
          child: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: context.isArabic ? 0 : 13,
                  right: context.isArabic ? 13 : 0,
                ),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: CustomLableAddressWidget(
                    text: "createNewPassword".tr(context),
                  ),
                ),
              ),
              const SizedBox(height: 15),
              CustomTextFormField(
                hint: "currentPassword".tr(context),
                isSecure: !cubit.isPasswordVisible,
                onChanged: (pass) {
                  cubit.currentPassword = pass;
                },
                validator: (value) => validatePassword(context, value),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: cubit.toggglePassIcon,
                  icon: Icon(
                    cubit.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.gray,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              CustomTextFormField(
                hint: "newPassword".tr(context),
                isSecure: !cubit.isPasswordVisible,
                onChanged: (pass) {
                  cubit.newPassword = pass;
                },
                validator: (value) => validatePassword(context, value),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: cubit.toggglePassIcon,
                  icon: Icon(
                    cubit.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.gray,
                  ),
                ),
              ),
              const Spacer(),

              GeneralButton(
                onPressed: () {
                  if (cubit.changePassFormKey.currentState!.validate()) {
                    cubit.changePassword();
                  }
                },
                text: state is ProfileChangePassLoading
                    ? "sending".tr(context)
                    : "save".tr(context),
              ),
              const SizedBox(height: 30),
            ],
          ),
        );
      },
    );
  }
}

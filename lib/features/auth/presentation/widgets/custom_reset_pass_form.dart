import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_done_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_lable_add_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';

class CustomResetPassForm extends StatelessWidget {
  const CustomResetPassForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();

    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Form(
          key: cubit.resetPassformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: context.isArabic ? 0 : 13,
                  right: context.isArabic ? 13 : 0,
                ),
                child: CustomLableAddressWidget(
                  text: "createNewPassword".tr(context),
                ),
              ),
              const SizedBox(height: 13),
              CustomTextFormField(
                hint: "password".tr(context),
                isSecure: !cubit.isPasswordVisible,
                onChanged: (pass) {
                  cubit.password = pass;
                },
                validator: (value) => validatePassword(context, value),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: cubit.togglePassIcon,
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
                hint: "confirmPassword".tr(context),
                isSecure: !cubit.isPasswordVisible,
                onChanged: (pass) {
                  cubit.confirmPassword = pass;
                },
                validator: (value) => validatePassword(context, value),
                prefixIcon: const Icon(Icons.lock),
                suffixIcon: IconButton(
                  onPressed: cubit.togglePassIcon,
                  icon: Icon(
                    cubit.isPasswordVisible
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColors.gray,
                  ),
                ),
              ),
              const VerticalSpace(height: 6),
              GeneralButton(
                onPressed: () {
                  if (cubit.resetPassformKey.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => const CustomDoneWidget(),
                    );
                  }
                },
                text: "savePassword".tr(context),
              ),
            ],
          ),
        );
      },
    );
  }
}

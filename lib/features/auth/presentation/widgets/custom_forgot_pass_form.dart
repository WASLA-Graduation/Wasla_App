import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:wasla/core/config/localization/app_localizations.dart';
import 'package:wasla/core/config/routes/app_routes.dart';
import 'package:wasla/core/extensions/config_extension.dart';
import 'package:wasla/core/extensions/custom_navigator_extension.dart';
import 'package:wasla/core/functions/toast_alert.dart';
import 'package:wasla/core/functions/validate_text_form_field.dart';
import 'package:wasla/core/utils/app_colors.dart';
import 'package:wasla/core/utils/app_spaces.dart';
import 'package:wasla/core/widgets/general_button.dart';
import 'package:wasla/features/auth/presentation/manager/cubit/auth_cubit.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_lable_add_widget.dart';
import 'package:wasla/features/auth/presentation/widgets/custom_text_form_field.dart';

class CustomForgotPassForm extends StatelessWidget {
  const CustomForgotPassForm({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<AuthCubit>();
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthForgotPassCheckEmailFailure) {
          toastAlert(color: AppColors.error, msg: state.errMsg);
        } else if (state is AuthForgotPassCheckEmailSuccess) {
          context.pushReplacementScreen(
            AppRoutes.verifyScreen,
            arguments: AppRoutes.resetPassScreen,
          );
        }
      },
      builder: (context, state) {
        return Form(
          key: cubit.forgotPassformKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  left: context.isArabic ? 0 : 13,
                  right: context.isArabic ? 13 : 0,
                ),
                child: CustomLableAddressWidget(
                  text: "emailAddress".tr(context),
                ),
              ),
              const SizedBox(height: 13),
              CustomTextFormField(
                prefixIcon: const Icon(Icons.email),
                hint: "emailAddress".tr(context),
                onChanged: (email) {
                  cubit.email = email;
                },
                validator: (value) => validateEmail(context, value),
              ),
              const VerticalSpace(height: 5),
              GeneralButton(
                text: state is AuthForgotPassCheckEmailLoading
                    ? "loading".tr(context)
                    : "sendVerificationCode".tr(context),
                onPressed: () async {
                  if (cubit.forgotPassformKey.currentState!.validate()) {
                    await cubit.forgotPassCheckEmail();
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
